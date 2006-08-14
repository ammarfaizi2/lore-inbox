Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWHNWHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWHNWHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 18:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWHNWHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 18:07:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:1466 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965001AbWHNWHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 18:07:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qCIlYK9XYXnRNZVcAyEP81Exq0ptmaM4ZaScvMQJX37QfILUjObWh5TriaEGHUtBc2vc5FiyjnVWC78DsbU3c6/wzGXWT3MTseo1wj5p+f2u573HgfxwKx9PtLVRi7xCTa8Li3rZe/0TBZTZ3pPjo9p2MCHZlqTKuLsFViUiBB8=
Message-ID: <44E0F44E.4010905@gmail.com>
Date: Tue, 15 Aug 2006 00:08:14 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Dinakar Guniguntala <dino@in.ibm.com>
Subject: Re: 2.6.18-rc4-mm1
References: <20060813012454.f1d52189.akpm@osdl.org> <6bffcb0e0608140702i70fb82ffr99a3ad6fdfbfd55e@mail.gmail.com> <20060814111914.b50f9b30.akpm@osdl.org> <44E0C889.3020706@gmail.com> <1155583256.5413.42.camel@localhost.localdomain> <6bffcb0e0608141227i2c4c48b6w8e18165ac406862@mail.gmail.com> <1155584697.5413.51.camel@localhost.localdomain> <44E0E1BA.3000204@gmail.com> <20060814205637.GA30814@redhat.com> <6bffcb0e0608141413u122c2a31scb3e170a776cec2b@mail.gmail.com> <20060814212022.GB30814@redhat.com>
In-Reply-To: <20060814212022.GB30814@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Mon, Aug 14, 2006 at 11:13:14PM +0200, Michal Piotrowski wrote:
>  > On 14/08/06, Dave Jones <davej@redhat.com> wrote:
>  > >  > Aug 14 22:30:09 ltg01-fedora kernel: general protection fault: 0000 [#1]
>  > >  > Aug 14 22:30:09 ltg01-fedora kernel: 4K_STACKS PREEMPT SMP
>  > >  > Aug 14 22:30:09 ltg01-fedora kernel: last sysfs file: /devices/platform/i2c-9191/9191-0290/temp2_input
>  > >  > Aug 14 22:30:09 ltg01-fedora kernel: CPU:    0
>  > >  > Aug 14 22:30:09 ltg01-fedora kernel: EIP:    0060:[<c0205249>]    Not tainted VLI
>  > >  > Aug 14 22:30:09 ltg01-fedora kernel: EFLAGS: 00010246   (2.6.18-rc4-mm1 #101)
>  > >  > Aug 14 22:30:09 ltg01-fedora kernel: EIP is at __list_add+0x3d/0x7a
>  > >  > Aug 14 22:30:09 ltg01-fedora kernel: eax: 00000000   ebx: c0670a80   ecx: c038d4dc   edx: 00000000
>  > >  > Aug 14 22:30:09 ltg01-fedora kernel: esi: ffffffff   edi: f50ebee8   ebp: f50ebed0   esp: f50ebec4
>  > >
>  > > __list_add will still be dereferencing prev->next, so you should see exactly
>  > > the same gpf. Note that you're not triggering the BUG()'s here, you're hitting
>  > > some other fault just walking the list.
>  > 
>  > How can I debug this?
> 
> Not sure. I'm somewhat puzzled.
> Disassembling the Code: of your oops shows that we were trying to dereference esi,
> which was -1 for some bizarre reason.  (my objdump really hated disassembling that
> function, but I think thats my tools rather than breakage in the oops).
> 
> Question is how did that list member get to be -1 ?
> One pie-in-the-sky possibility is that we've corrupted memory recently, and
> this link-list manipulation just stumbled across it.  Note that the last file
> opened before we blew up was reading i2c.

Or cpufreq

Aug 14 15:35:10 ltg01-fedora kernel: last sysfs file: /devices/platform/i2c-9191/9191-0290/temp2_input

Aug 14 15:39:12 ltg01-fedora kernel: last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_setspeed

Aug 14 22:30:09 ltg01-fedora kernel: last sysfs file: /devices/platform/i2c-9191/9191-0290/temp2_input

I haven't seen this bug on previous (2006-08-08) mm snapshot. Here are new i2c patches
apple-motion-sensor-driver-kconfig-fix.patch
kill-include-linux-configh.patch - it's my patch, I'm testing it for tree days.


Aug 14 15:35:11 ltg01-fedora kernel:  <6>note: firefox-bin[2210] exited with preempt_count 1

Aug 14 15:39:13 ltg01-fedora kernel:  <6>note: sendmail[1719] exited with preempt_count 1

Aug 14 22:30:10 ltg01-fedora kernel:  <6>note: thunderbird-bin[2288] exited with preempt_count 1

Is it possible that this is a problem with net stack?

Binary search will take ages - I don't know how to reproduce this bug.

>  Can you try and reproduce this
> (if you can reproduce it at all) without the sensors stuff loaded ?
> 
> It's a long-shot, but without further clues, I'm stabbing in the dark.
> 
> 		Dave
> 

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
