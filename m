Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVDFKPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVDFKPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 06:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVDFKPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 06:15:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52939 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262157AbVDFKPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 06:15:33 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Christophe Saout <christophe@saout.de>
Subject: Re: [BUG mm] "fixed" i386 memcpy inlining buggy
Date: Wed, 6 Apr 2005 13:14:27 +0300
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Jan Hubicka <hubicka@ucw.cz>,
       Gerold Jury <gerold.ml@inode.at>, jakub@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gcc@gcc.gnu.org
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu> <200504021526.53990.vda@ilport.com.ua> <1112718844.22591.15.camel@leto.cs.pocnet.net>
In-Reply-To: <1112718844.22591.15.camel@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061314.27740.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 April 2005 19:34, Christophe Saout wrote:
> Hi Denis,
> 
> the new i386 memcpy macro is a ticking timebomb.
> 
> I've been debugging a new mISDN crash, just to find out that a memcpy
> was not inlined correctly.
> 
> Andrew, you should drop the fix-i386-memcpy.patch (or have it fixed).
> 
> This source code:
> 
>         mISDN_pid_t     pid;
> 	[...]
>         memcpy(&st->mgr->pid, &pid, sizeof(mISDN_pid_t));
> 
> was compiled as:
> 
>         lea    0xffffffa4(%ebp),%esi    <---- %esi is loaded
> (       add    $0x10,%ebx                      )
> (       mov    %ebx,%eax                       ) something else
> (       call   1613 <test_stack_protocol+0x83> ) %esi preserved
>         mov    0xffffffa0(%ebp),%edx
>         mov    0x74(%edx),%edi          <---- %edi is loaded
>         add    $0x20,%edi                     offset in structure added
> !       mov    $0x14,%esi        !!!!!! <---- %esi overwritten!
>         mov    %esi,%ecx                <---- %ecx loaded
>         repz movsl %ds:(%esi),%es:(%edi)
> 
> Apparently the compiled decided that the value 0x14 could be reused
> afterwards (which it does for an inlined memset of the same size some
> instructions below) and clobbers %esi.
> 
> Looking at the macro:
> 
>                 __asm__ __volatile__(
>                         ""
>                         : "=&D" (edi), "=&S" (esi)
>                         : "0" ((long) to),"1" ((long) from)
>                         : "memory"
>                 );
>         }
>         if (n >= 5*4) {
>                 /* large block: use rep prefix */
>                 int ecx;
>                 __asm__ __volatile__(
>                         "rep ; movsl"
>                         : "=&c" (ecx)
> 
> it seems obvious that the compiled assumes it can reuse %esi and %edi
> for something else between the two __asm__ sections. These should
> probably be merged.

Oh shit. I was trying to be too clever. I still run with this patch,
so it must be happening very rarely.

Does this one compile ok?

static inline void * __constant_memcpy(void * to, const void * from, size_t n)
{
	long esi, edi;
#if 1	/* want to do small copies with non-string ops? */
	switch (n) {
		case 0: return to;
		case 1: *(char*)to = *(char*)from; return to;
		case 2: *(short*)to = *(short*)from; return to;
		case 4: *(int*)to = *(int*)from; return to;
#if 1	/* including those doable with two moves? */
		case 3: *(short*)to = *(short*)from;
			*((char*)to+2) = *((char*)from+2); return to;
		case 5: *(int*)to = *(int*)from;
			*((char*)to+4) = *((char*)from+4); return to;
		case 6: *(int*)to = *(int*)from;
			*((short*)to+2) = *((short*)from+2); return to;
		case 8: *(int*)to = *(int*)from;
			*((int*)to+1) = *((int*)from+1); return to;
#endif
	}
#else
	if (!n) return to;
#endif
	{
		/* load esi/edi */
		__asm__ __volatile__(
			""
			: "=&D" (edi), "=&S" (esi)
			: "0" ((long) to),"1" ((long) from)
			: "memory"
		);
	}
	if (n >= 5*4) {
		/* large block: use rep prefix */
		int ecx;
		__asm__ __volatile__(
			"rep ; movsl"
			: "=&c" (ecx), "=&D" (edi), "=&S" (esi)
			: "0" (n/4), "1" (edi),"2" (esi)
			: "memory"
		);
	} else {
		/* small block: don't clobber ecx + smaller code */
		if (n >= 4*4) __asm__ __volatile__("movsl":"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
		if (n >= 3*4) __asm__ __volatile__("movsl":"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
		if (n >= 2*4) __asm__ __volatile__("movsl":"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
		if (n >= 1*4) __asm__ __volatile__("movsl":"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory");
	}
	switch (n % 4) {
		/* tail */
		case 0: return to;
		case 1: __asm__ __volatile__("movsb":"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory"); return to;
		case 2: __asm__ __volatile__("movsw":"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory"); return to;
		default: __asm__ __volatile__("movsw\n\tmovsb":"=&D"(edi),"=&S"(esi):"0"(edi),"1"(esi):"memory"); return to;
	}
}
--
vda

