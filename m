Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbVKHVHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbVKHVHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbVKHVHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:07:16 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:1284 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030355AbVKHVHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:07:12 -0500
Message-ID: <4371137E.50202@vmware.com>
Date: Tue, 08 Nov 2005 13:07:10 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 4/21] i386 Broken bios common
References: <200511080422.jA84MQxK009859@zach-dev.vmware.com> <Pine.LNX.4.64.0511080703530.3247@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511080703530.3247@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2005 21:07:11.0280 (UTC) FILETIME=[62C76300:01C5E4A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Mon, 7 Nov 2005, Zachary Amsden wrote:
>  
>
>>Both the APM BIOS and PnP BIOS code use a segment hack to simulate real
>>mode selector 0x40 (which points to the BIOS data area at 0x00400 in
>>real mode).  Several broken BIOSen use selector 0x40 as if they were
>>running in real mode, which we make work by faking up selector 0x40 in
>>the GDT to point to physical memory starting at 0x400.  We limit the
>>access to the remainder of this physical page using a byte granular
>>limit.  Rather than have this tricky code in multiple places, it makes
>>sense to define it in one place, and the GDT makes a very convenient
>>place for it.  Use GDT entry 4 as the BAD_BIOS_CACHE segment.
>>    
>>
>
>I'd much rather use entry 8 instead, which should just automatically mean 
>that selector 0x40 _always_ points to virtual address 0x400. No switching 
>etc..
>
>Isn't this what Wine already has to work around, or something?
>
>Ingo, can we move the TLS selectors upwards, or does user space perhaps 
>know about the current TLS layout? Wine in particular may well know ;(
>  
>

Looking at the Wine code, it doesn't seem to know.  It uses a GDT entry 
if possible in preference to an LDT entry, and appears to not care which 
TLS descriptor it gets.  So I think it would be safe to reserve selector 
0x40 for the BIOS real mode segment and move TLS up.  That's kind of a 
scary change, but I don't see anything wrong with it other than the 
testing implications.  Hopefully DOSEmu is not affected..


/***********************************************************************
 *           wine_ldt_alloc_fs
 *
 * Allocate an LDT entry for a %fs selector, reusing a global
 * GDT selector if possible. Return the selector value.
 */
unsigned short wine_ldt_alloc_fs(void)
{
    if (global_fs_sel == -1)
    {
        struct modify_ldt_s ldt_info;
        int ret;

        ldt_info.entry_number = -1;   <---------  note it doesn't care
        fill_modify_ldt_struct( &ldt_info, &null_entry );
        if ((ret = set_thread_area( &ldt_info ) < 0))
        {
            global_fs_sel = 0;  /* don't try it again */
            if (errno != ENOSYS) perror( "set_thread_area" );
        }
        else global_fs_sel = (ldt_info.entry_number << 3) | 3;
    }
    if (global_fs_sel > 0) return global_fs_sel;
    return wine_ldt_alloc_entries( 1 );



