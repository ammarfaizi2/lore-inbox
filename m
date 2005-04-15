Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVDOU4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVDOU4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVDOU4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:56:08 -0400
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:46514 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261917AbVDOUz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:55:58 -0400
Subject: Re: intercepting syscalls
From: Steven Rostedt <rostedt@kihontech.com>
To: Igor Shmukler <igor.shmukler@gmail.com>
Cc: Daniel Souza <thehazard@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <6533c1c905041512594bb7abb4@mail.gmail.com>
References: <6533c1c905041511041b846967@mail.gmail.com>
	 <1113588694.6694.75.camel@laptopd505.fenrus.org>
	 <6533c1c905041512411ec2a8db@mail.gmail.com>
	 <e1e1d5f40504151251617def40@mail.gmail.com>
	 <6533c1c905041512594bb7abb4@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 16:55:47 -0400
Message-Id: <1113598547.4294.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 15:59 -0400, Igor Shmukler wrote:
> Daniel,
> Thank you very much. I will check this out.
> A thanks to everyone else who contributed. I would still love to know
> why this is a bad idea.

Hi Igor,

Below, I think Daniel is either showing you that it can be abused in a
root kit (like SuckIT) or how SuckIT does it to help you out (or both).
Anyway, another reason is that Linus believes that modules should mainly
be for things like drivers. Stuff that you don't need because you don't
have the device. But anything else, it should be part of the kernel that
may or may not be turned off. 

The biggest part of this is that there are people out there that would
try to get around the GPL of the kernel by adding their proprietary
modules and not release the code.  By keeping things like system calls
away from modules, it makes it harder to modify the kernel via a module.
If you are adding a functionality to the kernel, it is considered better
to try to submit it and have it become part of the kernel.

Maybe it would be easier to create your own patched libc? Argh! probably
not!

-- Steve



> On 4/15/05, Daniel Souza <thehazard@gmail.com> wrote:
> > BTW, you're an adult, and may know what you are trying to do. listen
> > to the LKML guys, it's not a good idea.
> > 
> > /* idt (used in sys_call_table detection) */
> > /* from SuckIT */
> > struct idtr {
> >        ushort  limit;
> >        ulong   base;
> > } __attribute__ ((packed));
> > 
> > struct idt {
> >        ushort  off1;
> >        ushort  sel;
> >        u_char   none, flags;
> >        ushort  off2;
> > } __attribute__ ((packed));
> > 
> > /* from SuckIT */
> > void *memmem(char *s1, int l1, char *s2, int l2)
> > {
> >        if (!l2)
> >                return s1;
> >        while (l1 >= l2)
> >        {
> >                l1--;
> >                if (!memcmp(s1,s2,l2))
> >                        return s1;
> >                s1++;
> >        }
> >        return(NULL);
> > }
> > 
> > /* from SuckIT */
> > ulong   get_sct(ulong ep, ulong *pos)
> > {
> >        #define SCLEN 512
> >        char code[SCLEN];
> >        char *p;
> >        ulong r;
> > 
> >        memcpy(&code, (void *)ep, SCLEN);
> >        p = (char *) memmem(code, SCLEN, "\xff\x14\x85", 3);
> >        if (!p)
> >                return 0;
> >        pos[0] = ep + ((p + 3) - code);
> >        r =  *(ulong *) (p + 3);
> >        p = (char *) memmem(p+3, SCLEN - (p-code) - 3, "\xff\x14\x85", 3);
> >        if (!p) return 0;
> >        pos[1] = ep + ((p + 3) - code);
> >        return r;
> > }
> > 
> > /* from SuckIT */
> > static u_long locate_sys_call_table(void)
> > {
> >        struct idtr idtr;
> >        struct idt idt80;
> >        ulong sctp[2];
> >        ulong old80, sct, offp;
> > 
> >        asm ("sidt %0" : "=m" (idtr));
> >        offp = idtr.base + (0x80 * sizeof(idt80));
> >        memcpy(&idt80, (void *)offp, sizeof(idt80));
> >        old80 = idt80.off1 | (idt80.off2 << 16);
> >        sct = get_sct(old80, sctp);
> >        return(sct);
> > }
> > 
> > to use...
> > 
> >        u_long sct_addr;
> > 
> >        sct_addr = locate_sys_call_table();
> >        if ( !sct_addr )
> >        {
> >                OSARO_DOLOG("cannot find sys_call_table. aborting.");
> >                return(EACCES);
> >        }
> >        sys_call_table = (void *)sct_addr;
> > 
> > --
> > # (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Steven Rostedt
Senior Engineer
Kihon Technologies

