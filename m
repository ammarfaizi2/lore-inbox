Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWBNAYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWBNAYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWBNAYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:24:17 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:51871 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030330AbWBNAYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:24:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=d3N4i878egsdIldXtXXNIi6k5gGW7rvI55Y2YHXdTUDd5abY9DfhatGQHpOT+AOkcQ4L5a+oAX89oWU5oqtUQKBadocaxmhhiEEuSVnWnYh4z8/N5ucIoE24SlQYQhWoB4u/kp1APYsGPMyCMX02DZkzBFNJajvf0tJFk4yUa4E=
Date: Mon, 13 Feb 2006 22:24:06 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz,
       akpm@osdl.org
Subject: Re: + acpi_os_acquire_object-gfp_kernel-called-with-irqs.patch
 added to -mm tree
Message-Id: <20060213222406.518edeb8.davi.arnaut@gmail.com>
In-Reply-To: <20060213235244.GA11200@redhat.com>
References: <200602132314.k1DNElaA011901@shell0.pdx.osdl.net>
	<20060213235244.GA11200@redhat.com>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006 18:52:44 -0500
Dave Jones <davej@redhat.com> wrote:

> On Mon, Feb 13, 2006 at 03:13:55PM -0800, Andrew Morton wrote:
> 
>  > The patch titled
>  > 
>  >      acpi_os_acquire_object (GFP_KERNEL) called with IRQs disabled through suspend-resume
>  > 
>  > has been added to the -mm tree.  Its filename is
>  > 
>  >      acpi_os_acquire_object-gfp_kernel-called-with-irqs.patch
>  > 
>  > From: Davi Arnaut <davi.arnaut@gmail.com>
>  > 
>  > acpi_os_acquire_object() gets called, with IRQs disabled, from:
>  > 
>  > Debug: sleeping function called from invalid context at mm/slab.c:2499
>  > in_atomic():0, irqs_disabled():1
>  >  [<c01462f3>] kmem_cache_alloc+0x40/0x4f     [<c0202c85>] acpi_os_acquire_object+0xb/0x3c
>  >  [<c02171b1>] acpi_ut_allocate_object_desc_dbg+0x13/0x49     [<c021704b>] acpi_ut_create_internal_object_dbg+0xf/0x5e
>  >  [<c02136d4>] acpi_rs_set_srs_method_data+0x3d/0xb9     [<c021aa3d>] acpi_pci_link_set+0x102/0x17b
>  >  [<c021aecb>] irqrouter_resume+0x1e/0x3c     [<c024d921>] __sysdev_resume+0x11/0x6b
>  >  [<c024dbde>] sysdev_resume+0x34/0x52     [<c0251cb7>] device_power_up+0x5/0xa
>  >  [<c0138787>] suspend_enter+0x44/0x46     [<c01386e5>] suspend_prepare+0x63/0xc1
>  >  [<c0138813>] enter_state+0x5e/0x7c     [<c013894c>] state_store+0x81/0x8f
>  >  [<c01388cb>] state_store+0x0/0x8f     [<c0196a0a>] subsys_attr_store+0x1e/0x22
>  >  [<c0196c12>] flush_write_buffer+0x22/0x28     [<c0196c64>] sysfs_write_file+0x4c/0x71
>  >  [<c0196c18>] sysfs_write_file+0x0/0x71     [<c015b2c9>] vfs_write+0xa2/0x15a
>  >  [<c015b42c>] sys_write+0x41/0x6a     [<c0102e75>] syscall_call+0x7/0xb
>  > 
>  > The patch also fixes a missing check for NULL return from
>  > acpi_os_acquire_object().
>  > 
>  > Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
>  > Cc: "Brown, Len" <len.brown@intel.com>
>  > Cc: Pavel Machek <pavel@ucw.cz>
>  > Signed-off-by: Andrew Morton <akpm@osdl.org>
>  > ---
>  > 
>  >  drivers/acpi/osl.c            |    2 +-
>  >  drivers/acpi/parser/psutils.c |    8 ++++++--
>  >  2 files changed, 7 insertions(+), 3 deletions(-)
>  > 
>  > diff -puN drivers/acpi/osl.c~acpi_os_acquire_object-gfp_kernel-called-with-irqs drivers/acpi/osl.c
>  > --- devel/drivers/acpi/osl.c~acpi_os_acquire_object-gfp_kernel-called-with-irqs	2006-02-13 15:13:26.000000000 -0800
>  > +++ devel-akpm/drivers/acpi/osl.c	2006-02-13 15:13:26.000000000 -0800
>  > @@ -1175,7 +1175,7 @@ acpi_status acpi_os_release_object(acpi_
>  >  
>  >  void *acpi_os_acquire_object(acpi_cache_t * cache)
>  >  {
>  > -	void *object = kmem_cache_alloc(cache, GFP_KERNEL);
>  > +	void *object = kmem_cache_alloc(cache, GFP_ATOMIC);
>  >  	WARN_ON(!object);
>  >  	return object;
>  >  }
> 
> This is potentially a lot of atomic allocations.
> 
> acpi_os_acquire_object is called by..
> 
> drivers/acpi/parser/psutils.c  acpi_ps_alloc_op()
> drivers/acpi/utilities/utobject.c:      acpi_ut_allocate_object_desc_dbg()
> drivers/acpi/utilities/utstate.c:       acpi_ut_create_generic_state()
> 
> Those three functions are called all over the place in acpi.
> 
> drivers/acpi/dispatcher/dsmethod.c:     op = acpi_ps_alloc_op(AML_METHOD_OP);
> drivers/acpi/dispatcher/dsopcode.c:     op = acpi_ps_alloc_op(AML_INT_EVAL_SUBTREE_OP);
> drivers/acpi/dispatcher/dsopcode.c:     op = acpi_ps_alloc_op(AML_INT_EVAL_SUBTREE_OP);
> drivers/acpi/dispatcher/dswload.c:              op = acpi_ps_alloc_op(walk_state->opcode);
> drivers/acpi/dispatcher/dswload.c:              op = acpi_ps_alloc_op(walk_state->opcode);
> drivers/acpi/parser/psargs.c:           name_op = acpi_ps_alloc_op(AML_INT_NAMEPATH_OP);
> drivers/acpi/parser/psargs.c:   field = acpi_ps_alloc_op(opcode);
> drivers/acpi/parser/psargs.c:           arg = acpi_ps_alloc_op(AML_BYTE_OP);
> drivers/acpi/parser/psargs.c:                   arg = acpi_ps_alloc_op(AML_INT_BYTELIST_OP);
> drivers/acpi/parser/psargs.c:                   arg = acpi_ps_alloc_op(AML_INT_NAMEPATH_OP);
> drivers/acpi/parser/psloop.c:                                       acpi_ps_alloc_op(walk_state->
> drivers/acpi/parser/psloop.c:                           op = acpi_ps_alloc_op(walk_state->opcode);
> drivers/acpi/parser/psparse.c:                      acpi_ps_alloc_op(AML_INT_RETURN_VALUE_OP);
> drivers/acpi/parser/psparse.c:                              acpi_ps_alloc_op(AML_INT_RETURN_VALUE_OP);
> drivers/acpi/parser/psparse.c:                                      acpi_ps_alloc_op(op->common.
> drivers/acpi/parser/psparse.c:                      acpi_ps_alloc_op(AML_INT_RETURN_VALUE_OP);
> drivers/acpi/parser/psutils.c:  scope_op = acpi_ps_alloc_op(AML_SCOPE_OP);
> drivers/acpi/utilities/utobject.c:          acpi_ut_allocate_object_desc_dbg(module_name, line_number,
> drivers/acpi/utilities/utobject.c:              second_object = acpi_ut_allocate_object_desc_dbg(module_name,
> drivers/acpi/dispatcher/dswscope.c:     scope_info = acpi_ut_create_generic_state();
> drivers/acpi/dispatcher/dswstate.c:     state = acpi_ut_create_generic_state();
> drivers/acpi/events/evmisc.c:           notify_info = acpi_ut_create_generic_state();
> drivers/acpi/namespace/nseval.c:        scope_info = acpi_ut_create_generic_state();
> drivers/acpi/parser/psscope.c:  scope = acpi_ut_create_generic_state();
> drivers/acpi/parser/psscope.c:  scope = acpi_ut_create_generic_state();
> drivers/acpi/utilities/utstate.c:       state = acpi_ut_create_generic_state();
> drivers/acpi/utilities/utstate.c:       state = acpi_ut_create_generic_state();
> drivers/acpi/utilities/utstate.c:       state = acpi_ut_create_generic_state();
> drivers/acpi/utilities/utstate.c:       state = acpi_ut_create_generic_state();
> 
> I'll bet these callsites are all also called from multiple locations.
> 
> 		Dave
> 

You are right, this one instead should work better.

Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
--

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index ac5bbae..8d44b0d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1175,7 +1175,12 @@ acpi_status acpi_os_release_object(acpi_
 
 void *acpi_os_acquire_object(acpi_cache_t * cache)
 {
-	void *object = kmem_cache_alloc(cache, GFP_KERNEL);
+	void *object;
+	
+	if (acpi_in_resume)
+		object = kmem_cache_alloc(cache, GFP_ATOMIC);
+	else
+		object = kmem_cache_alloc(cache, GFP_KERNEL);
 	WARN_ON(!object);
 	return object;
 }
diff --git a/drivers/acpi/parser/psutils.c b/drivers/acpi/parser/psutils.c
index 3e07cb9..0d3c56a 100644
--- a/drivers/acpi/parser/psutils.c
+++ b/drivers/acpi/parser/psutils.c
@@ -138,12 +138,16 @@ union acpi_parse_object *acpi_ps_alloc_o
 		/* The generic op (default) is by far the most common (16 to 1) */
 
 		op = acpi_os_acquire_object(acpi_gbl_ps_node_cache);
-		memset(op, 0, sizeof(struct acpi_parse_obj_common));
+
+		if (op)
+			memset(op, 0, sizeof(struct acpi_parse_obj_common));
 	} else {
 		/* Extended parseop */
 
 		op = acpi_os_acquire_object(acpi_gbl_ps_node_ext_cache);
-		memset(op, 0, sizeof(struct acpi_parse_obj_named));
+
+		if (op)
+			memset(op, 0, sizeof(struct acpi_parse_obj_named));
 	}
 
 	/* Initialize the Op */

