Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTJ2VPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 16:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTJ2VPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 16:15:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:21238 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261973AbTJ2VPM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 16:15:12 -0500
Message-ID: <3FA02DCF.4080906@mvista.com>
Date: Wed, 29 Oct 2003 13:14:55 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: jim.houston@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: Is there a kgdb for Opteron for linux-2.6?
References: <1066678923.1007.164.camel@new.localdomain>	<20031024135112.GE2286@wotan.suse.de>	<3F9EF206.1040105@mvista.com> <20031029002517.47d8f329.ak@suse.de>
In-Reply-To: <20031029002517.47d8f329.ak@suse.de>
Content-Type: multipart/mixed;
 boundary="------------080302030807030308000700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------080302030807030308000700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> On Tue, 28 Oct 2003 14:47:34 -0800
> George Anzinger <george@mvista.com> wrote:
> 
> 
> 
>>I see that Andrew has not picked up my latest kgdb.  In the latest version I 
>>have the dwarf2 stuff working in entry.S.  Just ask, off list.
> 
> 
> Do you use the .cfi* mnemonics in newer binutils? Without that it would get ugly.

I use asm mnemonics .uleb*, .sleb*, .byte and .long.  For operands I use the 
defines in dwarf2.h (after fixing them to work with asm).  These are, for the 
most part DW_CFA_* and other DW_* things.  I put this together to build macros 
(CCP) so that I can code things like:

	CFI_preamble(c1,_PC,1,1)
	CFA_define_reference(_ESP,OLDESP)
	CFA_define_offset(_EIP,EIP-OLDESP)
	CFA_define_offset(_EBX,EBX-OLDESP)	
	CFA_define_offset(_ECX,ECX-OLDESP)	
	CFA_define_offset(_EDX,EDX-OLDESP)	
	CFA_define_offset(_ESI,ESI-OLDESP)	
	CFA_define_offset(_EDI,EDI-OLDESP)	
	CFA_define_offset(_EBP,EBP-OLDESP)	
	CFA_define_offset(_EAX,EAX-OLDESP)	
	CFA_define_offset(_EFLAGS,EFLAGS-OLDESP)	
	CFI_postamble(c1)
	/*
          * This is VERY sloppy.  At this point all we want to do is get
          * the frame right for back tracing.  It will not be good if
          * you try to single step.  We use already defined labels.
          * We want to cover all call outs.
	 */
	FDE_preamble(c1,f0,do_lcall,(lcall27 - do_lcall))
	CFA_define_cfa_offset(OLDESP+8)
	FDE_postamble(f0)	
	FDE_preamble(c1,f00,ret_from_fork,(ret_from_intr - ret_from_fork))
	CFA_define_cfa_offset(OLDESP+4)
	FDE_postamble(f00)	
	FDE_preamble(c1,f1,ret_from_intr,(divide_error - ret_from_intr))
	FDE_postamble(f1)	
	FDE_preamble(c1,f2,error_code,(coprocessor_error - error_code))
	CFA_define_cfa_offset(OLDESP+8)
	FDE_postamble(f2)	
	FDE_preamble(c1,f3,device_not_available_emulate,(debug - 
device_not_available_emulate))
	CFA_define_cfa_offset(OLDESP+4)
	FDE_postamble(f3)	
	FDE_preamble(c1,f4,nmi_stack_correct,(nmi_stack_fixup - nmi_stack_correct))
	CFA_define_cfa_offset(OLDESP+8)
	FDE_postamble(f4)	


Which allows "bt" through entry.S code.  I did not try to allow you to get the 
correct answer if you stop in the middle of the register save or restore code.

I attached two files.  The dwarf2.h file I got from the cvs tree a few months 
ago and mung up to work with either asm or C.

The dwarf2-lang.h file is the one with the above macros.  This is a work in 
progress. I am working on adding the stack operations so I can tell gdb when to 
tie off the stack at an interrupt (its from user land) and when it can continue 
on through the interrupt.  This requires telling it to look at the stack and to 
come up with a different p-register.  (It took a while, but I have found that 
when gdb finds a return address of zero, it assumes that is the bottom of the 
stack and stops the back trace.)

Another trick I would like to try is to build a call frame for the out of line 
spinlock code.  I think if I can tell gdb to fetch the address part of the jmp 
back to the inline code as the return address, it will unwind correctly.  This, 
again, requires the stack ops...


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------080302030807030308000700
Content-Type: text/plain;
 name="dwarf2.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dwarf2.h"

/* Declarations and definitions of codes relating to the DWARF2 symbolic
   debugging information format.
   Copyright (C) 1992, 1993, 1995, 1996, 1997, 1999, 2000, 2001, 2002
   Free Software Foundation, Inc.

   Written by Gary Funck (gary@intrepid.com) The Ada Joint Program
   Office (AJPO), Florida State Unviversity and Silicon Graphics Inc.
   provided support for this effort -- June 21, 1995.

   Derived from the DWARF 1 implementation written by Ron Guilmette
   (rfg@netcom.com), November 1990.

   This file is part of GCC.

   GCC is free software; you can redistribute it and/or modify it under
   the terms of the GNU General Public License as published by the Free
   Software Foundation; either version 2, or (at your option) any later
   version.

   GCC is distributed in the hope that it will be useful, but WITHOUT
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
   or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
   License for more details.

   You should have received a copy of the GNU General Public License
   along with GCC; see the file COPYING.  If not, write to the Free
   Software Foundation, 59 Temple Place - Suite 330, Boston, MA
   02111-1307, USA.  */

/* This file is derived from the DWARF specification (a public document)
   Revision 2.0.0 (July 27, 1993) developed by the UNIX International
   Programming Languages Special Interest Group (UI/PLSIG) and distributed
   by UNIX International.  Copies of this specification are available from
   UNIX International, 20 Waterview Boulevard, Parsippany, NJ, 07054.

   This file also now contains definitions from the DWARF 3 specification.  */

/* This file is shared between GCC and GDB, and should not contain
   prototypes.	*/

#ifndef _ELF_DWARF2_H
#define _ELF_DWARF2_H

/* Structure found in the .debug_line section.	*/
#ifndef __ASSEMBLY__
typedef struct
{
  unsigned char li_length	   [4];
  unsigned char li_version	   [2];
  unsigned char li_prologue_length [4];
  unsigned char li_min_insn_length [1];
  unsigned char li_default_is_stmt [1];
  unsigned char li_line_base	   [1];
  unsigned char li_line_range	   [1];
  unsigned char li_opcode_base	   [1];
}
DWARF2_External_LineInfo;

typedef struct
{
  unsigned long  li_length;
  unsigned short li_version;
  unsigned int	 li_prologue_length;
  unsigned char  li_min_insn_length;
  unsigned char  li_default_is_stmt;
  int		 li_line_base;
  unsigned char  li_line_range;
  unsigned char  li_opcode_base;
}
DWARF2_Internal_LineInfo;

/* Structure found in .debug_pubnames section.	*/
typedef struct
{
  unsigned char pn_length  [4];
  unsigned char pn_version [2];
  unsigned char pn_offset  [4];
  unsigned char pn_size    [4];
}
DWARF2_External_PubNames;

typedef struct
{
  unsigned long  pn_length;
  unsigned short pn_version;
  unsigned long  pn_offset;
  unsigned long  pn_size;
}
DWARF2_Internal_PubNames;

/* Structure found in .debug_info section.  */
typedef struct
{
  unsigned char  cu_length	  [4];
  unsigned char  cu_version	  [2];
  unsigned char  cu_abbrev_offset [4];
  unsigned char  cu_pointer_size  [1];
}
DWARF2_External_CompUnit;

typedef struct
{
  unsigned long  cu_length;
  unsigned short cu_version;
  unsigned long  cu_abbrev_offset;
  unsigned char  cu_pointer_size;
}
DWARF2_Internal_CompUnit;

typedef struct
{
  unsigned char  ar_length	 [4];
  unsigned char  ar_version	 [2];
  unsigned char  ar_info_offset  [4];
  unsigned char  ar_pointer_size [1];
  unsigned char  ar_segment_size [1];
}
DWARF2_External_ARange;

typedef struct
{
  unsigned long  ar_length;
  unsigned short ar_version;
  unsigned long  ar_info_offset;
  unsigned char  ar_pointer_size;
  unsigned char  ar_segment_size;
}
DWARF2_Internal_ARange;

#define ENUM(name) enum name {
#define IF_NOT_ASM(a) a
#define COMMA ,
#else
#define ENUM(name)
#define IF_NOT_ASM(a)
#define COMMA 

#endif

/* Tag names and codes.  */
ENUM(dwarf_tag)

    DW_TAG_padding = 0x00 COMMA
    DW_TAG_array_type = 0x01 COMMA
    DW_TAG_class_type = 0x02 COMMA
    DW_TAG_entry_point = 0x03 COMMA
    DW_TAG_enumeration_type = 0x04 COMMA
    DW_TAG_formal_parameter = 0x05 COMMA
    DW_TAG_imported_declaration = 0x08 COMMA
    DW_TAG_label = 0x0a COMMA
    DW_TAG_lexical_block = 0x0b COMMA
    DW_TAG_member = 0x0d COMMA
    DW_TAG_pointer_type = 0x0f COMMA
    DW_TAG_reference_type = 0x10 COMMA
    DW_TAG_compile_unit = 0x11 COMMA
    DW_TAG_string_type = 0x12 COMMA
    DW_TAG_structure_type = 0x13 COMMA
    DW_TAG_subroutine_type = 0x15 COMMA
    DW_TAG_typedef = 0x16 COMMA
    DW_TAG_union_type = 0x17 COMMA
    DW_TAG_unspecified_parameters = 0x18 COMMA
    DW_TAG_variant = 0x19 COMMA
    DW_TAG_common_block = 0x1a COMMA
    DW_TAG_common_inclusion = 0x1b COMMA
    DW_TAG_inheritance = 0x1c COMMA
    DW_TAG_inlined_subroutine = 0x1d COMMA
    DW_TAG_module = 0x1e COMMA
    DW_TAG_ptr_to_member_type = 0x1f COMMA
    DW_TAG_set_type = 0x20 COMMA
    DW_TAG_subrange_type = 0x21 COMMA
    DW_TAG_with_stmt = 0x22 COMMA
    DW_TAG_access_declaration = 0x23 COMMA
    DW_TAG_base_type = 0x24 COMMA
    DW_TAG_catch_block = 0x25 COMMA
    DW_TAG_const_type = 0x26 COMMA
    DW_TAG_constant = 0x27 COMMA
    DW_TAG_enumerator = 0x28 COMMA
    DW_TAG_file_type = 0x29 COMMA
    DW_TAG_friend = 0x2a COMMA
    DW_TAG_namelist = 0x2b COMMA
    DW_TAG_namelist_item = 0x2c COMMA
    DW_TAG_packed_type = 0x2d COMMA
    DW_TAG_subprogram = 0x2e COMMA
    DW_TAG_template_type_param = 0x2f COMMA
    DW_TAG_template_value_param = 0x30 COMMA
    DW_TAG_thrown_type = 0x31 COMMA
    DW_TAG_try_block = 0x32 COMMA
    DW_TAG_variant_part = 0x33 COMMA
    DW_TAG_variable = 0x34 COMMA
    DW_TAG_volatile_type = 0x35 COMMA
    /* DWARF 3.  */
    DW_TAG_dwarf_procedure = 0x36 COMMA
    DW_TAG_restrict_type = 0x37 COMMA
    DW_TAG_interface_type = 0x38 COMMA
    DW_TAG_namespace = 0x39 COMMA
    DW_TAG_imported_module = 0x3a COMMA
    DW_TAG_unspecified_type = 0x3b COMMA
    DW_TAG_partial_unit = 0x3c COMMA
    DW_TAG_imported_unit = 0x3d COMMA
    /* SGI/MIPS Extensions.  */
    DW_TAG_MIPS_loop = 0x4081 COMMA
    /* GNU extensions.	*/
    DW_TAG_format_label = 0x4101 COMMA	/* For FORTRAN 77 and Fortran 90.  */
    DW_TAG_function_template = 0x4102 COMMA	/* For C++.  */
    DW_TAG_class_template = 0x4103 COMMA	/* For C++.  */
    DW_TAG_GNU_BINCL = 0x4104 COMMA
    DW_TAG_GNU_EINCL = 0x4105 COMMA
    /* Extensions for UPC.  See: http://upc.gwu.edu/~upc.  */
    DW_TAG_upc_shared_type = 0x8765 COMMA
    DW_TAG_upc_strict_type = 0x8766 COMMA
    DW_TAG_upc_relaxed_type = 0x8767
IF_NOT_ASM(};)

#define DW_TAG_lo_user	0x4080
#define DW_TAG_hi_user	0xffff

/* Flag that tells whether entry has a child or not.  */
#define DW_children_no	 0
#define	DW_children_yes  1

/* Form names and codes.  */
ENUM(dwarf_form)

    DW_FORM_addr = 0x01 COMMA
    DW_FORM_block2 = 0x03 COMMA
    DW_FORM_block4 = 0x04 COMMA
    DW_FORM_data2 = 0x05 COMMA
    DW_FORM_data4 = 0x06 COMMA
    DW_FORM_data8 = 0x07 COMMA
    DW_FORM_string = 0x08 COMMA
    DW_FORM_block = 0x09 COMMA
    DW_FORM_block1 = 0x0a COMMA
    DW_FORM_data1 = 0x0b COMMA
    DW_FORM_flag = 0x0c COMMA
    DW_FORM_sdata = 0x0d COMMA
    DW_FORM_strp = 0x0e COMMA
    DW_FORM_udata = 0x0f COMMA
    DW_FORM_ref_addr = 0x10 COMMA
    DW_FORM_ref1 = 0x11 COMMA
    DW_FORM_ref2 = 0x12 COMMA
    DW_FORM_ref4 = 0x13 COMMA
    DW_FORM_ref8 = 0x14 COMMA
    DW_FORM_ref_udata = 0x15 COMMA
    DW_FORM_indirect = 0x16
IF_NOT_ASM(};)

/* Attribute names and codes.  */

ENUM(dwarf_attribute)

    DW_AT_sibling = 0x01 COMMA
    DW_AT_location = 0x02 COMMA
    DW_AT_name = 0x03 COMMA
    DW_AT_ordering = 0x09 COMMA
    DW_AT_subscr_data = 0x0a COMMA
    DW_AT_byte_size = 0x0b COMMA
    DW_AT_bit_offset = 0x0c COMMA
    DW_AT_bit_size = 0x0d COMMA
    DW_AT_element_list = 0x0f COMMA
    DW_AT_stmt_list = 0x10 COMMA
    DW_AT_low_pc = 0x11 COMMA
    DW_AT_high_pc = 0x12 COMMA
    DW_AT_language = 0x13 COMMA
    DW_AT_member = 0x14 COMMA
    DW_AT_discr = 0x15 COMMA
    DW_AT_discr_value = 0x16 COMMA
    DW_AT_visibility = 0x17 COMMA
    DW_AT_import = 0x18 COMMA
    DW_AT_string_length = 0x19 COMMA
    DW_AT_common_reference = 0x1a COMMA
    DW_AT_comp_dir = 0x1b COMMA
    DW_AT_const_value = 0x1c COMMA
    DW_AT_containing_type = 0x1d COMMA
    DW_AT_default_value = 0x1e COMMA
    DW_AT_inline = 0x20 COMMA
    DW_AT_is_optional = 0x21 COMMA
    DW_AT_lower_bound = 0x22 COMMA
    DW_AT_producer = 0x25 COMMA
    DW_AT_prototyped = 0x27 COMMA
    DW_AT_return_addr = 0x2a COMMA
    DW_AT_start_scope = 0x2c COMMA
    DW_AT_stride_size = 0x2e COMMA
    DW_AT_upper_bound = 0x2f COMMA
    DW_AT_abstract_origin = 0x31 COMMA
    DW_AT_accessibility = 0x32 COMMA
    DW_AT_address_class = 0x33 COMMA
    DW_AT_artificial = 0x34 COMMA
    DW_AT_base_types = 0x35 COMMA
    DW_AT_calling_convention = 0x36 COMMA
    DW_AT_count = 0x37 COMMA
    DW_AT_data_member_location = 0x38 COMMA
    DW_AT_decl_column = 0x39 COMMA
    DW_AT_decl_file = 0x3a COMMA
    DW_AT_decl_line = 0x3b COMMA
    DW_AT_declaration = 0x3c COMMA
    DW_AT_discr_list = 0x3d COMMA
    DW_AT_encoding = 0x3e COMMA
    DW_AT_external = 0x3f COMMA
    DW_AT_frame_base = 0x40 COMMA
    DW_AT_friend = 0x41 COMMA
    DW_AT_identifier_case = 0x42 COMMA
    DW_AT_macro_info = 0x43 COMMA
    DW_AT_namelist_items = 0x44 COMMA
    DW_AT_priority = 0x45 COMMA
    DW_AT_segment = 0x46 COMMA
    DW_AT_specification = 0x47 COMMA
    DW_AT_static_link = 0x48 COMMA
    DW_AT_type = 0x49 COMMA
    DW_AT_use_location = 0x4a COMMA
    DW_AT_variable_parameter = 0x4b COMMA
    DW_AT_virtuality = 0x4c COMMA
    DW_AT_vtable_elem_location = 0x4d COMMA
    /* DWARF 3 values.	*/
    DW_AT_allocated	= 0x4e COMMA
    DW_AT_associated	= 0x4f COMMA
    DW_AT_data_location = 0x50 COMMA
    DW_AT_stride	= 0x51 COMMA
    DW_AT_entry_pc	= 0x52 COMMA
    DW_AT_use_UTF8	= 0x53 COMMA
    DW_AT_extension	= 0x54 COMMA
    DW_AT_ranges	= 0x55 COMMA
    DW_AT_trampoline	= 0x56 COMMA
    DW_AT_call_column	= 0x57 COMMA
    DW_AT_call_file	= 0x58 COMMA
    DW_AT_call_line	= 0x59 COMMA
    /* SGI/MIPS extensions.  */
    DW_AT_MIPS_fde = 0x2001 COMMA
    DW_AT_MIPS_loop_begin = 0x2002 COMMA
    DW_AT_MIPS_tail_loop_begin = 0x2003 COMMA
    DW_AT_MIPS_epilog_begin = 0x2004 COMMA
    DW_AT_MIPS_loop_unroll_factor = 0x2005 COMMA
    DW_AT_MIPS_software_pipeline_depth = 0x2006 COMMA
    DW_AT_MIPS_linkage_name = 0x2007 COMMA
    DW_AT_MIPS_stride = 0x2008 COMMA
    DW_AT_MIPS_abstract_name = 0x2009 COMMA
    DW_AT_MIPS_clone_origin = 0x200a COMMA
    DW_AT_MIPS_has_inlines = 0x200b COMMA
    /* GNU extensions.	*/
    DW_AT_sf_names   = 0x2101 COMMA
    DW_AT_src_info   = 0x2102 COMMA
    DW_AT_mac_info   = 0x2103 COMMA
    DW_AT_src_coords = 0x2104 COMMA
    DW_AT_body_begin = 0x2105 COMMA
    DW_AT_body_end   = 0x2106 COMMA
    DW_AT_GNU_vector = 0x2107 COMMA
    /* VMS extensions.	*/
    DW_AT_VMS_rtnbeg_pd_address = 0x2201 COMMA
    /* UPC extension.  */
    DW_AT_upc_threads_scaled = 0x3210
IF_NOT_ASM(};)

#define DW_AT_lo_user	0x2000	/* Implementation-defined range start.	*/
#define DW_AT_hi_user	0x3ff0	/* Implementation-defined range end.  */

/* Location atom names and codes.  */
ENUM(dwarf_location_atom)

    DW_OP_addr = 0x03 COMMA
    DW_OP_deref = 0x06 COMMA
    DW_OP_const1u = 0x08 COMMA
    DW_OP_const1s = 0x09 COMMA
    DW_OP_const2u = 0x0a COMMA
    DW_OP_const2s = 0x0b COMMA
    DW_OP_const4u = 0x0c COMMA
    DW_OP_const4s = 0x0d COMMA
    DW_OP_const8u = 0x0e COMMA
    DW_OP_const8s = 0x0f COMMA
    DW_OP_constu = 0x10 COMMA
    DW_OP_consts = 0x11 COMMA
    DW_OP_dup = 0x12 COMMA
    DW_OP_drop = 0x13 COMMA
    DW_OP_over = 0x14 COMMA
    DW_OP_pick = 0x15 COMMA
    DW_OP_swap = 0x16 COMMA
    DW_OP_rot = 0x17 COMMA
    DW_OP_xderef = 0x18 COMMA
    DW_OP_abs = 0x19 COMMA
    DW_OP_and = 0x1a COMMA
    DW_OP_div = 0x1b COMMA
    DW_OP_minus = 0x1c COMMA
    DW_OP_mod = 0x1d COMMA
    DW_OP_mul = 0x1e COMMA
    DW_OP_neg = 0x1f COMMA
    DW_OP_not = 0x20 COMMA
    DW_OP_or = 0x21 COMMA
    DW_OP_plus = 0x22 COMMA
    DW_OP_plus_uconst = 0x23 COMMA
    DW_OP_shl = 0x24 COMMA
    DW_OP_shr = 0x25 COMMA
    DW_OP_shra = 0x26 COMMA
    DW_OP_xor = 0x27 COMMA
    DW_OP_bra = 0x28 COMMA
    DW_OP_eq = 0x29 COMMA
    DW_OP_ge = 0x2a COMMA
    DW_OP_gt = 0x2b COMMA
    DW_OP_le = 0x2c COMMA
    DW_OP_lt = 0x2d COMMA
    DW_OP_ne = 0x2e COMMA
    DW_OP_skip = 0x2f COMMA
    DW_OP_lit0 = 0x30 COMMA
    DW_OP_lit1 = 0x31 COMMA
    DW_OP_lit2 = 0x32 COMMA
    DW_OP_lit3 = 0x33 COMMA
    DW_OP_lit4 = 0x34 COMMA
    DW_OP_lit5 = 0x35 COMMA
    DW_OP_lit6 = 0x36 COMMA
    DW_OP_lit7 = 0x37 COMMA
    DW_OP_lit8 = 0x38 COMMA
    DW_OP_lit9 = 0x39 COMMA
    DW_OP_lit10 = 0x3a COMMA
    DW_OP_lit11 = 0x3b COMMA
    DW_OP_lit12 = 0x3c COMMA
    DW_OP_lit13 = 0x3d COMMA
    DW_OP_lit14 = 0x3e COMMA
    DW_OP_lit15 = 0x3f COMMA
    DW_OP_lit16 = 0x40 COMMA
    DW_OP_lit17 = 0x41 COMMA
    DW_OP_lit18 = 0x42 COMMA
    DW_OP_lit19 = 0x43 COMMA
    DW_OP_lit20 = 0x44 COMMA
    DW_OP_lit21 = 0x45 COMMA
    DW_OP_lit22 = 0x46 COMMA
    DW_OP_lit23 = 0x47 COMMA
    DW_OP_lit24 = 0x48 COMMA
    DW_OP_lit25 = 0x49 COMMA
    DW_OP_lit26 = 0x4a COMMA
    DW_OP_lit27 = 0x4b COMMA
    DW_OP_lit28 = 0x4c COMMA
    DW_OP_lit29 = 0x4d COMMA
    DW_OP_lit30 = 0x4e COMMA
    DW_OP_lit31 = 0x4f COMMA
    DW_OP_reg0 = 0x50 COMMA
    DW_OP_reg1 = 0x51 COMMA
    DW_OP_reg2 = 0x52 COMMA
    DW_OP_reg3 = 0x53 COMMA
    DW_OP_reg4 = 0x54 COMMA
    DW_OP_reg5 = 0x55 COMMA
    DW_OP_reg6 = 0x56 COMMA
    DW_OP_reg7 = 0x57 COMMA
    DW_OP_reg8 = 0x58 COMMA
    DW_OP_reg9 = 0x59 COMMA
    DW_OP_reg10 = 0x5a COMMA
    DW_OP_reg11 = 0x5b COMMA
    DW_OP_reg12 = 0x5c COMMA
    DW_OP_reg13 = 0x5d COMMA
    DW_OP_reg14 = 0x5e COMMA
    DW_OP_reg15 = 0x5f COMMA
    DW_OP_reg16 = 0x60 COMMA
    DW_OP_reg17 = 0x61 COMMA
    DW_OP_reg18 = 0x62 COMMA
    DW_OP_reg19 = 0x63 COMMA
    DW_OP_reg20 = 0x64 COMMA
    DW_OP_reg21 = 0x65 COMMA
    DW_OP_reg22 = 0x66 COMMA
    DW_OP_reg23 = 0x67 COMMA
    DW_OP_reg24 = 0x68 COMMA
    DW_OP_reg25 = 0x69 COMMA
    DW_OP_reg26 = 0x6a COMMA
    DW_OP_reg27 = 0x6b COMMA
    DW_OP_reg28 = 0x6c COMMA
    DW_OP_reg29 = 0x6d COMMA
    DW_OP_reg30 = 0x6e COMMA
    DW_OP_reg31 = 0x6f COMMA
    DW_OP_breg0 = 0x70 COMMA
    DW_OP_breg1 = 0x71 COMMA
    DW_OP_breg2 = 0x72 COMMA
    DW_OP_breg3 = 0x73 COMMA
    DW_OP_breg4 = 0x74 COMMA
    DW_OP_breg5 = 0x75 COMMA
    DW_OP_breg6 = 0x76 COMMA
    DW_OP_breg7 = 0x77 COMMA
    DW_OP_breg8 = 0x78 COMMA
    DW_OP_breg9 = 0x79 COMMA
    DW_OP_breg10 = 0x7a COMMA
    DW_OP_breg11 = 0x7b COMMA
    DW_OP_breg12 = 0x7c COMMA
    DW_OP_breg13 = 0x7d COMMA
    DW_OP_breg14 = 0x7e COMMA
    DW_OP_breg15 = 0x7f COMMA
    DW_OP_breg16 = 0x80 COMMA
    DW_OP_breg17 = 0x81 COMMA
    DW_OP_breg18 = 0x82 COMMA
    DW_OP_breg19 = 0x83 COMMA
    DW_OP_breg20 = 0x84 COMMA
    DW_OP_breg21 = 0x85 COMMA
    DW_OP_breg22 = 0x86 COMMA
    DW_OP_breg23 = 0x87 COMMA
    DW_OP_breg24 = 0x88 COMMA
    DW_OP_breg25 = 0x89 COMMA
    DW_OP_breg26 = 0x8a COMMA
    DW_OP_breg27 = 0x8b COMMA
    DW_OP_breg28 = 0x8c COMMA
    DW_OP_breg29 = 0x8d COMMA
    DW_OP_breg30 = 0x8e COMMA
    DW_OP_breg31 = 0x8f COMMA
    DW_OP_regx = 0x90 COMMA
    DW_OP_fbreg = 0x91 COMMA
    DW_OP_bregx = 0x92 COMMA
    DW_OP_piece = 0x93 COMMA
    DW_OP_deref_size = 0x94 COMMA
    DW_OP_xderef_size = 0x95 COMMA
    DW_OP_nop = 0x96 COMMA
    /* DWARF 3 extensions.  */
    DW_OP_push_object_address = 0x97 COMMA
    DW_OP_call2 = 0x98 COMMA
    DW_OP_call4 = 0x99 COMMA
    DW_OP_call_ref = 0x9a COMMA
    /* GNU extensions.	*/
    DW_OP_GNU_push_tls_address = 0xe0
IF_NOT_ASM(};)

#define DW_OP_lo_user	0xe0	/* Implementation-defined range start.	*/
#define DW_OP_hi_user	0xff	/* Implementation-defined range end.  */

/* Type encodings.  */
ENUM(dwarf_type)

    DW_ATE_void = 0x0 COMMA
    DW_ATE_address = 0x1 COMMA
    DW_ATE_boolean = 0x2 COMMA
    DW_ATE_complex_float = 0x3 COMMA
    DW_ATE_float = 0x4 COMMA
    DW_ATE_signed = 0x5 COMMA
    DW_ATE_signed_char = 0x6 COMMA
    DW_ATE_unsigned = 0x7 COMMA
    DW_ATE_unsigned_char = 0x8 COMMA
    /* DWARF 3.  */
    DW_ATE_imaginary_float = 0x9
IF_NOT_ASM(};)

#define	DW_ATE_lo_user 0x80
#define	DW_ATE_hi_user 0xff

/* Array ordering names and codes.  */
ENUM(dwarf_array_dim_ordering)

    DW_ORD_row_major = 0 COMMA
    DW_ORD_col_major = 1
IF_NOT_ASM(};)

/* Access attribute.  */
ENUM(dwarf_access_attribute)

    DW_ACCESS_public = 1 COMMA
    DW_ACCESS_protected = 2 COMMA
    DW_ACCESS_private = 3
IF_NOT_ASM(};)

/* Visibility.	*/
ENUM(dwarf_visibility_attribute)

    DW_VIS_local = 1 COMMA
    DW_VIS_exported = 2 COMMA
    DW_VIS_qualified = 3
IF_NOT_ASM(};)

/* Virtuality.	*/
ENUM(dwarf_virtuality_attribute)

    DW_VIRTUALITY_none = 0 COMMA
    DW_VIRTUALITY_virtual = 1 COMMA
    DW_VIRTUALITY_pure_virtual = 2
IF_NOT_ASM(};)

/* Case sensitivity.  */
ENUM(dwarf_id_case)

    DW_ID_case_sensitive = 0 COMMA
    DW_ID_up_case = 1 COMMA
    DW_ID_down_case = 2 COMMA
    DW_ID_case_insensitive = 3
IF_NOT_ASM(};)

/* Calling convention.	*/
ENUM(dwarf_calling_convention)

    DW_CC_normal = 0x1 COMMA
    DW_CC_program = 0x2 COMMA
    DW_CC_nocall = 0x3
IF_NOT_ASM(};)

#define DW_CC_lo_user 0x40
#define DW_CC_hi_user 0xff

/* Inline attribute.  */
ENUM(dwarf_inline_attribute)

    DW_INL_not_inlined = 0 COMMA
    DW_INL_inlined = 1 COMMA
    DW_INL_declared_not_inlined = 2 COMMA
    DW_INL_declared_inlined = 3
IF_NOT_ASM(};)

/* Discriminant lists.	*/
ENUM(dwarf_discrim_list)

    DW_DSC_label = 0 COMMA
    DW_DSC_range = 1
IF_NOT_ASM(};)

/* Line number opcodes.  */
ENUM(dwarf_line_number_ops)

    DW_LNS_extended_op = 0 COMMA
    DW_LNS_copy = 1 COMMA
    DW_LNS_advance_pc = 2 COMMA
    DW_LNS_advance_line = 3 COMMA
    DW_LNS_set_file = 4 COMMA
    DW_LNS_set_column = 5 COMMA
    DW_LNS_negate_stmt = 6 COMMA
    DW_LNS_set_basic_block = 7 COMMA
    DW_LNS_const_add_pc = 8 COMMA
    DW_LNS_fixed_advance_pc = 9 COMMA
    /* DWARF 3.  */
    DW_LNS_set_prologue_end = 10 COMMA
    DW_LNS_set_epilogue_begin = 11 COMMA
    DW_LNS_set_isa = 12
IF_NOT_ASM(};)

/* Line number extended opcodes.  */
ENUM(dwarf_line_number_x_ops)

    DW_LNE_end_sequence = 1 COMMA
    DW_LNE_set_address = 2 COMMA
    DW_LNE_define_file = 3
IF_NOT_ASM(};)

/* Call frame information.  */
ENUM(dwarf_call_frame_info)

    DW_CFA_advance_loc = 0x40 COMMA
    DW_CFA_offset = 0x80 COMMA
    DW_CFA_restore = 0xc0 COMMA
    DW_CFA_nop = 0x00 COMMA
    DW_CFA_set_loc = 0x01 COMMA
    DW_CFA_advance_loc1 = 0x02 COMMA
    DW_CFA_advance_loc2 = 0x03 COMMA
    DW_CFA_advance_loc4 = 0x04 COMMA
    DW_CFA_offset_extended = 0x05 COMMA
    DW_CFA_restore_extended = 0x06 COMMA
    DW_CFA_undefined = 0x07 COMMA
    DW_CFA_same_value = 0x08 COMMA
    DW_CFA_register = 0x09 COMMA
    DW_CFA_remember_state = 0x0a COMMA
    DW_CFA_restore_state = 0x0b COMMA
    DW_CFA_def_cfa = 0x0c COMMA
    DW_CFA_def_cfa_register = 0x0d COMMA
    DW_CFA_def_cfa_offset = 0x0e COMMA

    /* DWARF 3.  */
    DW_CFA_def_cfa_expression = 0x0f COMMA
    DW_CFA_expression = 0x10 COMMA
    DW_CFA_offset_extended_sf = 0x11 COMMA
    DW_CFA_def_cfa_sf = 0x12 COMMA
    DW_CFA_def_cfa_offset_sf = 0x13 COMMA

    /* SGI/MIPS specific.  */
    DW_CFA_MIPS_advance_loc8 = 0x1d COMMA

    /* GNU extensions.	*/
    DW_CFA_GNU_window_save = 0x2d COMMA
    DW_CFA_GNU_args_size = 0x2e COMMA
    DW_CFA_GNU_negative_offset_extended = 0x2f
IF_NOT_ASM(};)

#define DW_CIE_ID	  0xffffffff
#define DW_CIE_VERSION	  1

#define DW_CFA_extended   0
#define DW_CFA_lo_user	  0x1c
#define DW_CFA_hi_user	  0x3f

#define DW_CHILDREN_no		     0x00
#define DW_CHILDREN_yes		     0x01

#define DW_ADDR_none		0

/* Source language names and codes.  */
ENUM(dwarf_source_language)

    DW_LANG_C89 = 0x0001 COMMA
    DW_LANG_C = 0x0002 COMMA
    DW_LANG_Ada83 = 0x0003 COMMA
    DW_LANG_C_plus_plus = 0x0004 COMMA
    DW_LANG_Cobol74 = 0x0005 COMMA
    DW_LANG_Cobol85 = 0x0006 COMMA
    DW_LANG_Fortran77 = 0x0007 COMMA
    DW_LANG_Fortran90 = 0x0008 COMMA
    DW_LANG_Pascal83 = 0x0009 COMMA
    DW_LANG_Modula2 = 0x000a COMMA
    DW_LANG_Java = 0x000b COMMA
    /* DWARF 3.  */
    DW_LANG_C99 = 0x000c COMMA
    DW_LANG_Ada95 = 0x000d COMMA
    DW_LANG_Fortran95 = 0x000e COMMA
    /* MIPS.  */
    DW_LANG_Mips_Assembler = 0x8001 COMMA
    /* UPC.  */
    DW_LANG_Upc = 0x8765
IF_NOT_ASM(};)

#define DW_LANG_lo_user 0x8000	/* Implementation-defined range start.	*/
#define DW_LANG_hi_user 0xffff	/* Implementation-defined range start.	*/

/* Names and codes for macro information.  */
ENUM(dwarf_macinfo_record_type)

    DW_MACINFO_define = 1 COMMA
    DW_MACINFO_undef = 2 COMMA
    DW_MACINFO_start_file = 3 COMMA
    DW_MACINFO_end_file = 4 COMMA
    DW_MACINFO_vendor_ext = 255
IF_NOT_ASM(};)

/* @@@ For use with GNU frame unwind information.  */

#define DW_EH_PE_absptr		0x00
#define DW_EH_PE_omit		0xff

#define DW_EH_PE_uleb128	0x01
#define DW_EH_PE_udata2		0x02
#define DW_EH_PE_udata4		0x03
#define DW_EH_PE_udata8		0x04
#define DW_EH_PE_sleb128	0x09
#define DW_EH_PE_sdata2		0x0A
#define DW_EH_PE_sdata4		0x0B
#define DW_EH_PE_sdata8		0x0C
#define DW_EH_PE_signed		0x08

#define DW_EH_PE_pcrel		0x10
#define DW_EH_PE_textrel	0x20
#define DW_EH_PE_datarel	0x30
#define DW_EH_PE_funcrel	0x40
#define DW_EH_PE_aligned	0x50

#define DW_EH_PE_indirect	0x80

#endif /* _ELF_DWARF2_H */

--------------080302030807030308000700
Content-Type: text/plain;
 name="dwarf2-lang.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dwarf2-lang.h"

#ifndef DWARF2_LANG
#define DWARF2_LANG
#include <linux/dwarf2.h>

/*
 * This is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2, or (at your option) any later
 * version.
 */
/*
 * This file defines macros that allow generation of DWARF debug records
 * for asm files.  This file is platform independent.  Register numbers
 * (which are about the only thing that is platform dependent) are to be
 * supplied by a platform defined file.
 */
#define DWARF_preamble()	.section	.debug_frame,"",@progbits
/*
 * This macro starts a debug frame section.  The debug_frame describes
 * where to find the registers that the enclosing function saved on
 * entry.
 *
 * ORD is use by the label generator and should be the same as what is
 * passed to CFI_postamble.
 *
 * pc,	pc register gdb ordinal.
 *
 * code_align this is the factor used to define locations or regions
 * where the given definitions apply.  If you use labels to define these
 * this should be 1.
 *
 * data_align this is the factor used to define register offsets.  If
 * you use struct offset, this should be the size of the register in
 * bytes or the negative of that.  This is how it is used: you will
 * define a register as the reference register, say the stack pointer,
 * then you will say where a register is located relative to this
 * reference registers value, say 40 for register 3 (the gdb register
 * number).  The <40> will be multiplied by <data_align> to define the
 * byte offset of the given register (3, in this example).  So if your
 * <40> is the byte offset and the reference register points at the
 * begining, you would want 1 for the data_offset.  If <40> was the 40th
 * 4-byte element in that structure you would want 4.  And if your
 * reference register points at the end of the structure you would want
 * a negative data_align value(and you would have to do other math as
 * well).
 */

#define CFI_preamble(ORD, pc, code_align, data_align)	\
.section	.debug_frame,"",@progbits ;		\
	.align 4;				\
frame/**/_/**/ORD:					\
	.long end/**/_/**/ORD-start/**/_/**/ORD;	\
start/**/_/**/ORD:					\
	.long	DW_CIE_ID;				\
	.byte	DW_CIE_VERSION;				\
	.byte 0	 ;					\
	.uleb128 code_align;				\
	.sleb128 data_align;				\
	.byte pc;

/*
 * After the above macro and prior to the CFI_postamble, you need to
 * define the initial state.  This starts with defining the reference
 * register and, usually the pc.  Here are some helper macros:
 */

#define CFA_define_reference(reg, offset)	\
	.byte DW_CFA_def_cfa;			\
	.uleb128 reg;				\
	.uleb128 (offset);

#define CFA_define_offset(reg, offset)		\
	.byte (DW_CFA_offset + reg);		\
	.uleb128 (offset);

#define CFI_postamble(ORD)			\
	.align 4;				\
end/**/_/**/ORD:
/*
 * So now your code pushs stuff on the stack, you need a new location
 * and the rules for what to do.  This starts a running description of
 * the call frame.  You need to describe what changes with respect to
 * the call registers as the location of the pc moves through the code.
 * The following builds an FDE (fram descriptor entry?).  Like the
 * above, it has a preamble and a postamble.  It also is tied to the CFI
 * above.
 * The first entry after the preamble must be the location in the code
 * that the call frame is being described for.
 */
#define FDE_preamble(ORD, fde_no, initial_address, length)	\
	.align 4;				\
	.long FDE_end/**/_/**/fde_no-FDE_start/**/_/**/fde_no;		\
FDE_start/**/_/**/fde_no:						\
	.long frame/**/_/**/ORD;					\
	.long initial_address;					\
	.long length;

#define FDE_postamble(fde_no)			\
	.align 4;				\
FDE_end/**/_/**/fde_no:
/*
 * That done, you can now add registers, subtract registers, move the
 * reference and even change the reference.  You can also define a new
 * area of code the info applies to.  For discontinuous bits you should
 * start a new FDE.  You may have as many as you like.
 */

/*
 * To advance the address by <bytes>
 */

#define FDE_advance(bytes)			\
	.byte DW_CFA_advance_loc4		\
	.long bytes



/*
 * With the above you can define all the register locations.  But
 * suppose the reference register moves... Takes the new offset NOT an
 * increment.  This is how esp is tracked if it is not saved.
 */

#define CFA_define_cfa_offset(offset) \
	.byte DW_CFA_def_cfa_offset; \
	.uleb128 (offset);
/*
 * Or suppose you want to use a different reference register...
 */
#define CFA_define_cfa_register(reg)		\
	.byte DW_CFA_def_cfa_register;		\
	.uleb128 reg;


/*
 * Here we do the expression stuff
 */

#define CFA_expression_preamble(exno,reg)				\
        .leb128 reg;							\
	.uleb128 DW_FORM_end/**/_/**/exno-DW_FORM_start/**/_/**/exno;	\
DW_FORM_start/**/_/**/exno:

#define CFA_expression_postamble(exno)		\
DW_FORM_end/**/_/**/exno:

#define CFA_exp_push_addr(a) 			\
        .byte DW_OP_addr;			\
        .long a;

#define CFA_exp_push_const4s(a) 			\
        .byte DW_OP_const4s;			\
        .long a;

#define  CFA_exp_swap  .byte DW_OP_swap;
#define  CFA_exp_dup  .byte DW_OP_dup;
#define  CFA_exp_drop  .byte DW_OP_drop;
/*
 * All these work on the top two elements on the stack, replacing them
 * with the result.  Top comes first where it matters.  True is 1, false 0.
 */
#define  CFA_exp_deref  .byte DW_OP_deref;
#define  CFA_exp_and  .byte DW_OP_and;
#define  CFA_exp_div  .byte DW_OP_div;
#define  CFA_exp_minus  .byte DW_OP_minus;
#define  CFA_exp_mod  .byte DW_OP_mod;
#define  CFA_exp_neg  .byte DW_OP_neg;
#define  CFA_exp_plus  .byte DW_OP_plus;
#define  CFA_exp_not  .byte DW_OP_not;
#define  CFA_exp_or  .byte DW_OP_or;
#define  CFA_exp_xor  .byte DW_OP_xor;
#define  CFA_exp_OP_le .byte DW_OP_le;
#define  CFA_exp_OP_ge .byte DW_OP_ge;
#define  CFA_exp_OP_eq .byte DW_OP_eq;
#define  CFA_exp_OP_lt .byte DW_OP_lt;
#define  CFA_exp_OP_gt .byte DW_OP_gt;
#define  CFA_exp_OP_ne .byte DW_OP_ne;

/*
 * To use the result...
 */
#define  CFA_exp_OP_skip(count) 		\
       .byte DW_OP_skip;			\
       .lbe???  count;



#endif

--------------080302030807030308000700--

