Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVCXHvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVCXHvQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVCXHvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:51:16 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:2258 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262715AbVCXHvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:51:04 -0500
Subject: Re: [RFC] Obtaining memory information for kexec/kdump
From: Dave Hansen <haveblue@us.ibm.com>
To: "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <424254E0.6060003@in.ibm.com>
References: <424254E0.6060003@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-gzH/NE2vVDZYzVoVW3je"
Date: Wed, 23 Mar 2005 23:50:44 -0800
Message-Id: <1111650644.9881.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gzH/NE2vVDZYzVoVW3je
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-03-24 at 11:19 +0530, Hariprasad Nellitheertha wrote:
> The topic of creating a common interface across 
> architectures for obtaining system RAM information has been 
> discussed on lkml and fastboot for a while now.

Sorry, I missed this on LKML.

> Kexec needs 
> information about the entire physical RAM present in the 
> system while kdump needs information on the memory that the 
> kernel has booted with.

I think there's likely a lot of commonality with the needs of memory
hotplug systems here.  We effectively dump out the physical layout of
the system, but in sysfs.  We do this mostly because any memory hotplug
changes generate hotplug events, just like all other hardware.  If you
do this in /proc, it's another thing that memory hotplug will have to
update.  

Also, we already have a concept of active and non-active physical
memory: we call it online and offline.  Some tweaks to the information
that we export might be all that you need, instead of creating a new
interface.  I've attached a document I started writing a couple days ago
about the sysfs layout and the call paths for hotplug.  It's horribly
incomplete, but not a bad start.

If you want to see some more details of the layout, please check out
this patch set:

http://www.sr71.net/patches/2.6.12/2.6.12-rc1-mhp1/patch-2.6.12-rc1-mhp1.gz

A good example of all of the hotplug stuff enabled for a normal machine
is this .config, it boots on my 4-way PIII Xeon.  

http://www.sr71.net/patches/2.6.12/2.6.12-rc1-mhp1/configs/config-i386-sparse-hotplug

You're welcome to borrow the machine that I normally boot this config
on.  Should make booting it relatively foolproof. :)

-- Dave

--=-gzH/NE2vVDZYzVoVW3je
Content-Disposition: attachment; filename=hotplug-docco.txt
Content-Type: text/plain; name=hotplug-docco.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

block_size_bytes:  The size of each memory section (in hex)

memoryXXXX: Each directory contains individual information about
	that memory section.  The number associated with the
	memory section is arbitrary, and should not be
	used for any calculations, it is a useless tag.

memoryXXXX/phys_index: multiply this by block_size_bytes and you
	can calculate the starting physical address of this
	memory section.  This is so that you can directly 
	correlate the memoryXXXX directory with any probe that
	you've issued.

probe: The user may write a physical address into this file to
	initate a hot-addition of a new memory section.  

echo 0x00000000 > /sys/devices/system/memory/probe
memory_probe_store()
  add_memory()
	  __add_pages()
	  __add_section()
		allocate section memmap
		lock zone
		register_new_memory()
			add_memory_block()
			register_memory()
				create kobject -> generates hotplug event
			sysfs create files()
		unlock zone

/sbin/hotplug sees "ADD" event, calls:

#!/bin/sh
# goes in /etc/hotplug.d/memory/onlinenow.hotplug
if [ "$ACTION" != "add" ]; then
	exit 0;
fi
while ! [ -f $SYSFS/$DEVPATH/state ]; do
	sleep 0.1;
done
echo online > "$SYSFS/$DEVPATH/state"

store_mem_state()
	memory_block_change_state()
		memory_block_action()
		|------>online_pages()
		|		online_page()
		|			__free_page()
		\------>remove_memory()
				__remove_pages()
					capture_page_range()
					unregister_memory_section()
						-> generates unplug event
		

--=-gzH/NE2vVDZYzVoVW3je--

