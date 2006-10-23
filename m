Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWJWOmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWJWOmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWJWOmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:42:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:56524 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964887AbWJWOmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:42:21 -0400
Date: Mon, 23 Oct 2006 10:41:45 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>, Magnus Damm <magnus@valinux.co.jp>,
       linux-kernel@vger.kernel.org, patches@x86-64.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, Ian.Campbell@XenSource.com
Subject: Re: [patches] [PATCH] [18/19] x86_64: Overlapping program headers in physical addr space fix
Message-ID: <20061023144145.GB15532@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061021651.356252000@suse.de> <20061021165138.B8B5E13C4D@wotan.suse.de> <453C8966.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453C8966.76E4.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 08:20:38AM +0100, Jan Beulich wrote:
> >@@ -17,6 +17,7 @@ PHDRS {
> > 	text PT_LOAD FLAGS(5);	/* R_E */
> > 	data PT_LOAD FLAGS(7);	/* RWE */
> > 	user PT_LOAD FLAGS(7);	/* RWE */
> >+	data.init PT_LOAD FLAGS(7);	/* RWE */
> > 	note PT_NOTE FLAGS(4);	/* R__ */
> > }
> > SECTIONS
> 
> Even though it's only cosmetic, I think it would have been
> more than appropriate to remove the ill 'E' permission on data
> with that change.

May be. I just kept it because already data segment had 'E' permissions.
Ian, any reason why did you keep 'E' on data segment? If it is not
intentional, I will get rid of it.

>(Btw., why does 'note' need 'R'?)

I went through the comments Ian had put in his patch. There also he 
mentions that people objected to 'R' permissions for note segment as
it is read only by boot loader. He kept it because i386 had the similar
thing. 

Ian, again if there is no specific reason to keep 'R' for note, I will
get rid of it.

> Also, I
> consider the naming of the new segment misleading - just 'init'
> would have been more correct.
> 

I think plain "init" also does not reflect the correct name as this section
is also mapping .data.init_task, .data.page_aligned and .data_nosave, which
will probably never get freed. It maps smp alternatives sections which will
not be freed if CPU_HOTPLUG is enabled. It also maps .bss, which will never
get freed.

I think, the sections which are not being freed, should be moved up and
made part of 'data' segment. Then create a segment 'init' for all the init
text/data and finally create another segment say 'bss' to map bss at the
end. How does this sound?

Thanks
Vivek

