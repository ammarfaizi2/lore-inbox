Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWINA0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWINA0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 20:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWINA0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 20:26:18 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:12724 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751261AbWINA0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 20:26:18 -0400
Message-ID: <4508A191.1060203@vmware.com>
Date: Wed, 13 Sep 2006 17:25:53 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
Subject: Re: Assignment of GDT entries
References: <450854F3.20603@goop.org>	 <1158175001.3054.7.camel@laptopd505.fenrus.org> <4508681E.3070708@goop.org>	 <4508711B.6060905@vmware.com> <1158183322.16902.8.camel@localhost.localdomain>
In-Reply-To: <1158183322.16902.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Mer, 2006-09-13 am 13:59 -0700, ysgrifennodd Zachary Amsden:
>   
>> TLS #3 overlaps BIOS 0x40, but code which calls borken APM / PnP BIOS 
>> and sets up protected mode 0x40 GDT segment does so by swapping out the 
>> TLS segment with the identity simulation of physical 0x400 offset, 
>> swapping it back afterwards.  Short of bugs in that code (which there 
>> are, btw), you shouldn't need to be concerned with it.
>>     
>
> Care to elucidate ?
>   

I believe the current max use case for GDT descriptors is Wine.  Wine 
compiled against TLS glibc uses entry zero for libc, and allocates 
another GDT entry for the first thread created by NTDLL (although I have 
no idea why, since there is fallback code to use LDT allocation instead, 
and all subsequent allocations happen via the LDT -  perhaps some kernel 
mode DLL thing insists on having the first thread in the GDT?)  DOSemu 
by the way, only uses the LDT.

But there is no reason userspace can't allocate 3 TLS descriptors in the 
GDT per thread.  If it did, the overlap between 0x40 (descriptor #8, 
real mode BIOS simulation of physical address 0x400, BIOS data area) 
causes a problem.  Fortunately, APM and PnP take care to fix this by 
swapping in and out the descriptors.  Unfortunately, they don't get it 
quite right.

Selected code snippets (PnP):

        /*
         * PnP BIOSes are generally not terribly re-entrant.
         * Also, don't rely on them to save everything correctly.
         */
        if(pnp_bios_is_utter_crap)
                return PNP_FUNCTION_NOT_SUPPORTED;

        cpu = get_cpu();
        save_desc_40 = get_cpu_gdt_table(cpu)[0x40 / 8];
        get_cpu_gdt_table(cpu)[0x40 / 8] = bad_bios_desc;   <---- set up 
fake BIOS descriptor for 0x400

        /* On some boxes IRQ's during PnP BIOS calls are deadly.  */
        spin_lock_irqsave(&pnp_bios_lock, flags);

...  now inline assembler

                "pushl %%fs\n\t"
                "pushl %%gs\n\t"
                "pushfl\n\t"
                "movl %%esp, pnp_bios_fault_esp\n\t"
                "movl $1f, pnp_bios_fault_eip\n\t"
                "lcall %5,%6\n\t"
                "1:popfl\n\t"
                "popl %%gs\n\t"   <---- (**)
                "popl %%fs\n\t"    <---- (**)

... now restore original GDT descriptor back

        spin_unlock_irqrestore(&pnp_bios_lock, flags);

        get_cpu_gdt_table(cpu)[0x40 / 8] = save_desc_40;
        put_cpu();


But it is too late - damage is already done (at **), since %fs or %gs 
could have had a reference to TLS descriptor #3, and they get reloaded 
_before_ the GDT is restored.  Thus any userspace process that uses TLS 
descriptor #3 in FS or GS and makes a BIOS call to PnP may get corrupted 
data loaded into the hidden state of FS / GS selectors.

APM has a similar problem.  Both are easily fixable, but there has been 
too much flux in this area recently to get a stable patch for these 
problems, and the problems are exceedingly unlikely, since I don't know 
of a single userspace program using TLS descriptor #3, much less one 
that makes use of APM or PnP facilities.  There is the possibility 
however, that such a program could sleep, run the idle thread, which 
makes a call into some of these BIOS facilities, and then reschedules 
the same program thread - which means FS/GS never get reloaded, thus 
maintaining their corrupted values.  It is worth fixing, just not a high 
priority.  I had a patch that fixed both APM and PnP at one time, but it 
is covered with mold and now looks like a science experiment.  Shall I 
apply disinfectant?

Zach
