Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVA1UfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVA1UfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVA1UeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:34:02 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63198 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262742AbVA1Ubd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:31:33 -0500
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<1106294155.26219.26.camel@2fwv946.in.ibm.com>
	<m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	<1106305073.26219.46.camel@2fwv946.in.ibm.com>
	<m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
	<1106475280.26219.125.camel@2fwv946.in.ibm.com>
	<m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
	<1106833527.15652.146.camel@2fwv946.in.ibm.com>
	<m1zmyueh4c.fsf@ebiederm.dsl.xmission.com>
	<1106917583.15652.234.camel@2fwv946.in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jan 2005 13:29:38 -0700
In-Reply-To: <1106917583.15652.234.camel@2fwv946.in.ibm.com>
Message-ID: <m1r7k5e1ql.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Hi Eric,
> 
> 
> However for the primary kernel it has no need to know that we
> > even have a backup region, nor does it need to know about the
> > size of the backup region.  That can all be handled with the single
> > reservation, we have now.  
> > 
> > /sbin/kexec which makes the backup needs to know about it and it needs
> > to pass that information on.  But the primary kernel does not. 
> 
> 
> Agreed. Primary kernel need not to be aware of backup region and 
> reservation of this region can be better managed from user space.

Good.  It sound like we are pretty much back on the same page then.

> > > Boot time parameter crashbackup=A@B has been provided to pass this
> > > information to capture kernel. This parameter is valid only for capture
> > > kernel and becomes effective only if CONFIG_CRASH_DUMP is enabled.
> > 
> > But that is not what you implemented.  crashbackup= was an alternative
> > to the carving out of 640K in parts 1-3.
> 
> 
> Not really. crashbackup= is not being used for carving out backup
> region. It is just used for passing the address of this region to second
> kernel. That's why it has been put under CONFIG_CRASH_DUMP.

Ok I missed a piece in your patch.  You have crashdumpk_res, and
crashbackup_start, crashbackup_end.   And I missed the fact that
they were different variables as they dealt with the same concept.

So that patch actually should have been three patches.  The
one line bug fix.  The crashdumpk_res bit (which I strongly
object to) and the crashbackup_start/_end bit.  The fact
that all three were in the same patch is a reviewing and maintenance
pain.

Please in the future do not include code that runs in the primary
kernel and crashdump specific code that runs in the capture kernel in
the same patch.

> This looks good. So memory regions are parsed from /proc/iomem and this
> information is put in one data segment and stored in reserved region
> during panic kernel load time.
> 
> But I am unable to co-relate as to how the capture tool (even if its all
> in user space) gets to know the address of this segment (or for that
> matter, the bss segment created for backup region). Am I missing
> something obvious.

There are a lot of choices at that point.
Place the data in the on the kernel command line, and pick
it up from /proc/cmdline.
Place the data in a file on the initramfs.
Place the data in a user space data segment.


> > However as long as we gracefully handle the interface
> > between the primary kernel and the capture kernel we can
> > switch mechanisms for actually taking the crash dump,
> > kernel based or user space as seems most sane.
> 
> 
> This seems to be a good direction.

Cool.

One of the ideas worth exploring is to see about stabilizing the
other side of this interface as well.   That is we should explore
providing a fixed interface coming out of purgatory.ro to the new
kernel and it's user space (i.e. the ELF header like thing).  I think
we are quite close to that point already.  And this goes back to your
question of how do we let the capture kernel/user space know where to
look.

Eric
