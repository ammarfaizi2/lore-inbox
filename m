Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWAJMfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWAJMfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWAJMfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:35:48 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:35497 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750799AbWAJMfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:35:47 -0500
Date: Tue, 10 Jan 2006 21:34:49 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: keith <kmannth@us.ibm.com>, Andi Kleen <ak@suse.de>
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Matt Tolentino <metolent@cs.vt.edu>, akpm@osdl.org, discuss@x86-64.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1136837348.31043.105.camel@knk>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C0B777A@fmsmsx406.amr.corp.intel.com> <1136837348.31043.105.camel@knk>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060110201604.38B0.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2006-01-09 at 11:55 -0800, Tolentino, Matthew E wrote:
> > Andi Kleen <mailto:ak@suse.de> wrote:
> > > On Monday 09 January 2006 16:21, Matt Tolentino wrote:
> > >> Add x86-64 specific memory hot-add functions, Kconfig options,
> > >> and runtime kernel page table update functions to make
> > >> hot-add usable on x86-64 machines.  Also, fixup the nefarious
> > >> conditional locking and exports pointed out by Andi.
> > > 
> > > I'm trying to stabilize my tree for the 2.6.16 submission right now
> > > and this one comes a bit too late and is a bit too involved
> > > to slip through - sorry. I will consider it after Linus
> > > has merged the whole batch of changes for 2.6.16 - so hopefully
> > > in 2.6.17.
> > > 
> > >> +/*
> > >> + * Memory hotplug specific functions
> > >> + * These are only for non-NUMA machines right now.
> > > 
> > > How much work would it be to allow it for NUMA kernels too?
> 
> Not too much.

Hmm. If there is already a pgdat for new memory, it is not too much.
Just searching is necessary, which node new memory belongs to.

But, if not (this means it is new node), then it must not only allocate
and initialize new pgdat, all node's zonelists also must be updated,
because other zonelists don't know there is new node's zone.
And kmalloc is not good for allocation of new pgdat as further step.
The new pgdat should be on new own nodes for performance,
but kmalloc can't allocate on it, because its node is not initialized
itself.

I've worked for it for long time, and I have patch set against 
2.6.14-rc12-git8-mhp1. But it needs many patches which have
included stock kernel, so I would like to move 2.6.15-mm2.
(Fortunately, basis of memory-hot add is included in stock kernel.
 So, I would like to post them step by step like followings.

1st) There is pgdat for new memory.
2nd) allocate pgdat by kmalloc.
3rd) allocate pgdat on its nodes.

But, in addition, mempolicy and cpusets also must be updated.
I've not worked for it yet.


>  I have a start of this code.  Just saving off the SRAT
> locality information and using it during the add-event to decide which
> node it goes to. But I went to test this weekend on a multi-node system
> and the underlying __add_pages refused to add the pages.  The underlying
> sparsemem can do this (It works for PPC).  I am still collecting the
> debug info needed.
> 
> When I get the numa system sorted I will post patches. 

IIRC, SRAT is just for booting time. So, when hotplug occured,
it is not reliable. DSDT should be used for it in order to SRAT
like following 2 patches. 
First is to get pxm from physical address.
I'll post the second patch after this post.

Thanks.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: current_source/drivers/acpi/acpi_memhotplug.c
===================================================================
--- current_source.orig/drivers/acpi/acpi_memhotplug.c	2005-12-27 16:21:40.000000000 +0900
+++ current_source/drivers/acpi/acpi_memhotplug.c	2005-12-27 20:39:45.000000000 +0900
@@ -81,6 +81,22 @@ struct acpi_memory_device {
 };
 
 static int
+acpi_get_node_id(acpi_handle *handle, int *nid)
+{
+	int pxm;
+
+	ACPI_FUNCTION_TRACE("acpi_get_node_id");
+
+	pxm = acpi_get_pxm(handle);
+	if (pxm < 0)
+		return_VALUE(-ENODEV);
+
+	*nid = acpi_map_pxm_to_nid(pxm);
+
+	return_VALUE(0);
+}
+
+static int
 acpi_memory_get_device_resources(struct acpi_memory_device *mem_device)
 {
 	acpi_status status;
@@ -532,6 +548,78 @@ static acpi_status __init acpi_memory_se
 	return acpi_memory_set_name(mem_device);
 }
 
+struct find_memdevice_arg{
+	u64 start_addr;
+	u64 size;
+};
+
+acpi_status
+acpi_memory_match_paddr_to_memdevice(acpi_handle handle, u32 lvl, void *context, void **retv)
+{
+	acpi_status status;
+	struct acpi_device *device = NULL;
+	struct find_memdevice_arg *arg = context;
+	struct acpi_memory_device *mem_device = NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_match_paddr_to_memdevice\n");
+
+	status = is_memory_device(handle);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(AE_OK);       /* Not memory device. continue */
+
+	if (acpi_bus_get_device(handle, &device) || !device)
+		return_ACPI_STATUS(AE_OK);       /* Device is not attached. continue */
+
+	mem_device = acpi_driver_data(device);
+	if ((status = acpi_memory_check_device(mem_device)) < 0)
+		return_ACPI_STATUS(AE_OK);       /* Not online. continue */
+
+	if (mem_device->start_addr > arg->start_addr ||
+	    mem_device->end_addr + 1 < arg->start_addr + arg->size)
+		return_ACPI_STATUS(AE_OK);      /* Not match. continue */
+
+	*retv = (void *)mem_device;
+
+	return_ACPI_STATUS(AE_CTRL_TERMINATE);
+}
+
+static int
+acpi_memory_find_memdevice(u64 start_addr, u64 size,
+			struct acpi_memory_device **mem_device)
+{
+	acpi_status status;
+	struct find_memdevice_arg arg;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_find_memdevice\n");
+
+	arg.start_addr = start_addr;
+	arg.size = size;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX,
+				     acpi_memory_match_paddr_to_memdevice,
+				     (void *)&arg, (void **)mem_device);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "walk_namespace_failed at acpi_memory_fine_memdevice\n"));
+		return_VALUE(-ENODEV);
+	}
+	return_VALUE(0);
+}
+
+int
+acpi_search_node_id(u64 start_addr, u64 size)
+{
+	struct acpi_memory_device *mem_device;
+	int nid = -1;
+	ACPI_FUNCTION_TRACE("acpi_search_node_id\n");
+
+	if (!acpi_memory_find_memdevice(start_addr, size, &mem_device))
+		acpi_get_node_id(mem_device->handle, &nid);
+
+	return_VALUE(nid);
+}
+
 static int __init acpi_memory_device_init(void)
 {
 	int result;

-- 
Yasunori Goto 


