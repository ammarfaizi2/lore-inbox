Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbQKGXrC>; Tue, 7 Nov 2000 18:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131690AbQKGXqB>; Tue, 7 Nov 2000 18:46:01 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:17927 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131404AbQKGXo6>; Tue, 7 Nov 2000 18:44:58 -0500
Message-ID: <3A0892B1.81396527@timpanogas.org>
Date: Tue, 07 Nov 2000 16:39:29 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: kernel@kvack.org, Martin Josefsson <gandalf@wlug.westbo.se>,
        Tigran Aivazian <tigran@veritas.com>, Anil kumar <anils_r@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.21.0011071606490.8417-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:
> 
> Jeff, the problem is not detecting the CPU type at runtime, the problem is
> trying to re-compile the code to take advantage of that CPU at runtime.
> 
> depending on what CPU you have the kernel (and compiler) can use different
> commands/opmizations/etc, if you want to do this on boot you have two
> options.
> 
> 1. re-compile the kernel
> 
> 2. change all the CPU specific places from inline code to function calls
> into a table that get changed at boot to point at the correct calls.

The macros would be a problem.  Some of the options, like MTRR, should
be auto-detected.

Jeff

> 
> doing #2 will cost you so much performance that you would be better off
> just compiling for a 386 and not going through the autodetect hassle in
> the first place.
> 
> David Lang
> 
>  On Tue, 7 Nov 2000, Jeff V. Merkey wrote:
> 
> > Date: Tue, 07 Nov 2000 16:10:58 -0700
> > From: Jeff V. Merkey <jmerkey@timpanogas.org>
> > To: kernel@kvack.org
> > Cc: Martin Josefsson <gandalf@wlug.westbo.se>,
> >      Tigran Aivazian <tigran@veritas.com>, Anil kumar <anils_r@yahoo.com>,
> >      linux-kernel@vger.kernel.org
> > Subject: Re: Installing kernel 2.4
> >
> >
> > There are tests for all this in the feature flags for intel and
> > non-intel CPUs like AMD -- including MTRR settings.  All of this could
> > be dynamic.  Here's some code that does this, and it's similiar to
> > NetWare.  It detexts CPU type, feature flags, special instructions,
> > etc.  All of this on x86 could be dynamically detected.
> >
> > :-)
> >
> > ;*************************************************************************
> > ;
> > ;  check current processor type and state
> > ;
> > ;*************************************************************************
> >
> > public DetectProcessorInformation
> > DetectProcessorInformation proc near
> >
> >     mov   ax, cs
> >     mov   ds, ax
> >     mov   es, ax
> >
> >     pushf
> >     call  get_cpuid
> >     call  get_fpuid
> >     call  print
> >     popf
> >     ret
> >
> > DetectProcessorInformation endp
> >
> > get_cpuid proc near
> >
> > check_8086:
> >
> >     pushf
> >     pop   ax
> >     mov   cx, ax
> >     and   ax, 0fffh
> >     push  ax
> >     popf
> >     pushf
> >     pop   ax
> >     and   ax, 0f000h
> >     cmp   ax, 0f000h    ; flag bits 12-15 are always set on an 8086
> >     mov   CPU_TYPE, 0   ; 8086 detected
> >     je    end_get_cpuid
> >
> > check_80286:
> >     or    cx, 0f000h
> >     push  cx
> >     popf
> >     pushf
> >     pop   ax
> >     and   ax, 0f000h   ; flag bits 12-15 are always clear on 80286 in
> > real mode
> >     mov   CPU_TYPE, 2  ; 80286 processor
> >     jz    end_get_cpuid
> >
> > check_80386:
> >     mov     bx, sp
> >     and     sp, not 3
> >     OPND32
> >     pushf
> >     OPND32
> >     pop ax
> >     OPND32
> >     mov      cx, ax
> >     OPND32   35h, 40000h
> >     OPND32
> >     push     ax
> >     OPND32
> >     popf
> >     OPND32
> >     pushf
> >     OPND32
> >     pop      ax
> >     OPND32
> >     xor      ax, cx       ; AC bit won't toggle, 80386 detected
> >     mov      sp, bx
> >     mov      CPU_TYPE, 3  ; 80386 detected
> >     jz       end_get_cpuid
> >
> >     and      sp, not 3
> >     OPND32
> >     push     cx
> >     OPND32
> >     popf
> >     mov      sp, bx     ; restore stack
> >
> >
> > check_80486:
> >     mov      CPU_TYPE, 4     ; default to 80486
> >
> >     OPND32
> >     mov      ax, cx
> >     OPND32   35h, 200000h      ; xor ID bit
> >     OPND32
> >     push ax
> >     OPND32
> >     popf
> >     OPND32
> >     pushf
> >     OPND32
> >     pop      ax
> >     OPND32
> >     xor      ax, cx           ; cant toggle ID bit
> >     je       end_get_cpuid
> >
> >
> > check_vendor:
> >     mov     ID_FLAG, 1
> >     OPND32
> >     xor     ax, ax
> >     CPUID
> >     OPND32
> >     mov     word ptr VENDOR_ID, bx
> >     OPND32
> >     mov     word ptr VENDOR_ID[+4], dx
> >     OPND32
> >     mov     word ptr VENDOR_ID[+8], cx
> >     mov     si, offset VENDOR_ID
> >     mov     di, offset intel_id
> >     mov     cx, length intel_id
> >
> > compare:
> >     repe    cmpsb
> >     or      cx, cx
> >     jnz     end_get_cpuid
> >
> > intel_processor:
> >     mov     INTEL_PROC, 1
> >
> > cpuid_data:
> >     OPND32
> >     cmp     ax, 1
> >
> >     jl      end_get_cpuid
> >     OPND32
> >     xor     ax, ax
> >     OPND32
> >     inc     ax
> >     CPUID
> >     mov     byte ptr ds:STEPPING, al
> >     and     STEPPING, STEPPING_MASK
> >
> >     and     al, MODEL_MASK
> >     shr     al, MODEL_SHIFT
> >     mov     byte ptr ds:CPU_MODEL, al
> >
> >     and     ax, FAMILY_MASK
> >     shr     ax, FAMILY_SHIFT
> >     mov     byte ptr ds:CPU_TYPE, al
> >
> >     mov     dword ptr FEATURE_FLAGS, edx
> >
> > end_get_cpuid:
> >     ret
> >
> > get_cpuid  endp
> >
> >
> > get_fpuid proc near
> >
> >     fninit
> >     mov      word ptr ds:FP_STATUS, 5a5ah
> >
> >     fnstsw   word ptr ds:FP_STATUS
> >     mov      ax, word ptr ds:FP_STATUS
> >     cmp      al, 0
> >
> >     mov      FPU_TYPE, 0
> >     jne      end_get_fpuid
> >
> > check_control_word:
> >     fnstcw   word ptr ds:FP_STATUS
> >     mov      ax, word ptr ds:FP_STATUS
> >     and      ax, 103fh
> >     cmp      ax, 3fh
> >
> >     mov      FPU_TYPE, 0
> >     jne      end_get_fpuid
> >     mov      FPU_TYPE, 1
> >
> >
> > check_infinity:
> >     cmp      CPU_TYPE, 3
> >     jne      end_get_fpuid
> >     fld1
> >     fldz
> >     fdiv
> >     fld      st
> >     fchs
> >     fcompp
> >     fstsw    word ptr ds:FP_STATUS
> >     mov      ax, word ptr ds:FP_STATUS
> >     mov      FPU_TYPE, 2
> >
> >     sahf
> >     jz       end_get_fpuid
> >     mov      FPU_TYPE, 3
> > end_get_fpuid:
> >     ret
> > get_fpuid endp
> >
> >
> >
> > print proc near
> >     cmp      ID_FLAG, 1
> >     je       print_cpuid_data
> >
> > if (VERBOSE)
> >     mov      dx, offset id_msg
> >     call     OutputMessage
> > endif
> >
> > print_86:
> >     cmp      CPU_TYPE, 0
> >     jne      print_286
> >
> > if (VERBOSE)
> >     mov      dx, offset c8086
> >     call     OutputMessage
> > endif
> >     cmp      FPU_TYPE, 0
> >     je       end_print
> >
> > if (VERBOSE)
> >     mov      dx, offset fp_8087
> >     call     OutputMessage
> > endif
> >     jmp      end_print
> >
> > print_286:
> >     cmp      CPU_TYPE, 2
> >     jne      print_386
> > if (VERBOSE)
> >     mov      dx, offset c286
> >     call     OutputMessage
> > endif
> >     cmp      FPU_TYPE, 0
> >     je       end_print
> > if (VERBOSE)
> >     mov      dx, offset fp_80287
> >     call     OutputMessage
> > endif
> >     jmp      end_print
> >
> > print_386:
> >     cmp      CPU_TYPE, 3
> >     jne      print_486
> > if (VERBOSE)
> >     mov      dx, offset c386
> >     call     OutputMessage
> > endif
> >     cmp      FPU_TYPE, 0
> >     je       end_print
> >     cmp      FPU_TYPE, 2
> >     jne      print_387
> > if (VERBOSE)
> >     mov      dx, offset fp_80287
> >     call     OutputMessage
> > endif
> >     jmp      end_print
> >
> > print_387:
> > if (VERBOSE)
> >     mov      dx, offset fp_80387
> >     call     OutputMessage
> > endif
> >     jmp      end_print
> >
> > print_486:
> >     cmp      FPU_TYPE, 0
> >     je       print_Intel486sx
> > if (VERBOSE)
> >     mov      dx, offset c486
> >     call     OutputMessage
> > endif
> >     jmp      end_print
> >
> > print_Intel486sx:
> > if (VERBOSE)
> >     mov      dx, offset c486nfp
> >     call     OutputMessage
> > endif
> >     jmp      end_print
> >
> > print_cpuid_data:
> >
> > cmp_vendor:
> >     cmp      INTEL_PROC, 1
> >     jne      not_GenuineIntel
> >
> >     cmp      CPU_TYPE, 4
> >     jne      check_Pentium
> > if (VERBOSE)
> >     mov      dx, offset Intel486_msg
> >     call     OutputMessage
> > endif
> >     jmp      print_family
> >
> > check_Pentium:
> >     cmp      CPU_TYPE, 5
> >     jne      check_PentiumPro
> > if (VERBOSE)
> >     mov      dx, offset Pentium_msg
> >     call     OutputMessage
> > endif
> >     jmp      print_family
> >
> > check_PentiumPro:
> >     cmp      CPU_TYPE, 6
> >     jne      print_features
> > if (VERBOSE)
> >     mov      dx, offset PentiumPro_msg
> >     call     OutputMessage
> > endif
> >
> > print_family:
> >
> > IF VERBOSE
> >     mov      dx, offset family_msg
> >     call     OutputMessage
> > ENDIF
> >
> >     mov      al, byte ptr ds:CPU_TYPE
> >     mov      byte ptr dataCR, al
> >     add      byte ptr dataCR, 30h
> >
> > IF VERBOSE
> >     mov      dx, offset dataCR
> >     call     OutputMessage
> > ENDIF
> >
> > print_model:
> >
> > IF VERBOSE
> >     mov      dx, offset model_msg
> >     call     OutputMessage
> > ENDIF
> >
> >     mov      al, byte ptr ds:CPU_MODEL
> >     mov      byte ptr dataCR, al
> >     add      byte ptr dataCR, 30h
> >
> > IF VERBOSE
> >     mov      dx, offset dataCR
> >     call     OutputMessage
> > ENDIF
> >
> > print_features:
> >     mov      ax, word ptr ds:FEATURE_FLAGS
> >     and      ax, FPU_FLAG
> >     jz       check_mce
> >
> > if (VERBOSE)
> >     mov      dx, offset fpu_msg
> >     call     OutputMessage
> > ENDIF
> >
> > check_mce:
> >     mov      ax, word ptr ds:FEATURE_FLAGS
> >     and      ax, MCE_FLAG
> >     jz       check_wc
> >
> > IF VERBOSE
> >     mov      dx, offset mce_msg
> >     call     OutputMessage
> > ENDIF
> >
> > check_CMPXCHG8B:
> >     mov      ax, word ptr ds:FEATURE_FLAGS
> >     and      ax, CMPXCHG8B_FLAG
> >     jz       check_4MB_paging
> >
> > IF VERBOSE
> >     mov      dx, offset cmp_msg
> >     call     OutputMessage
> > ENDIF
> >
> > chekc_io_break:
> >     mov      ax, word ptr ds:FEATURE_FLAGS
> >     test     ax, 4
> >     jz       check_4MB_paging
> >
> > IF VERBOSE
> >     mov      dx, offset io_break_msg
> >     call     OutputMessage
> > ENDIF
> >
> >     ; Enable Debugging Extensions bit in CR4
> >     CR4_TO_ECX
> >     or        ecx, 08h
> >     ECX_TO_CR4
> >
> > if (VERBOSE)
> >     mov      dx, offset io_break_enable
> >     call     OutputMessage
> > endif
> >
> > check_4MB_paging:
> >     mov      ax, word ptr ds:FEATURE_FLAGS
> >     test     ax, 08h
> >     jz       check_PageExtend
> >
> > IF VERBOSE
> >     mov      dx, offset page_4MB_msg
> >     call     OutputMessage
> > ENDIF
> >
> >     ; Enable page size extension bit in CR4
> >     CR4_TO_ECX
> >     or             ecx, 10h
> >     ECX_TO_CR4
> >
> > if (VERBOSE)
> >     mov      dx, offset p4mb_enable
> >     call     OutputMessage
> > endif
> >
> > check_PageExtend:
> >     mov      ax, word ptr ds:FEATURE_FLAGS
> >     test     ax, 40h
> >     jz       check_wc
> >
> > ;; DEBUG DEBUG DEBUG !!!
> >     ; Enable page address extension bit in CR4
> >
> >     ;; CR4_TO_ECX
> >     ;; or          ecx, 20h
> >     ;; ECX_TO_CR4
> >
> > check_wc:
> >     mov      dx, word ptr ds:FEATURE_FLAGS
> >     test     dx, 1000h ; MTRR support flag
> >     jz       end_print
> >
> > if (VERBOSE)
> >     mov      dx, offset wc_enable
> >     call     OutputMessage
> > endif
> >     jmp      end_print
> >
> > not_GenuineIntel:
> > if (VERBOSE)
> >     mov      dx, offset not_Intel
> >     call     OutputMessage
> > endif
> >
> > end_print:
> >     ret
> > print endp
> >
> >
> > kernel@kvack.org wrote:
> > >
> > > On Tue, 7 Nov 2000, Jeff V. Merkey wrote:
> > >
> > > > So how come NetWare and NT can detect this at run time, and we have to
> > > > use a .config option to specifiy it?  Come on guys.....
> > >
> > > Then run a kernel compiled for i386 and suffer the poorer code quality
> > > that comes with not using newer instructions and including the
> > > workarounds for ancient hardware.
> > >
> > >                 -ben
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > Please read the FAQ at http://www.tux.org/lkml/
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> >
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
