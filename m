Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVHUV2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVHUV2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVHUV2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:28:24 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:61711 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751123AbVHUV2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:28:23 -0400
Message-ID: <4308F1EF.9020609@rainbow-software.org>
Date: Sun, 21 Aug 2005 23:28:15 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: FPU-intensive programs crashing with floating point   exception
 on Cyrix MII
References: <200508210550_MC3-1-A7CF-D29E@compuserve.com> <Pine.LNX.4.58.0508211043520.3317@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508211043520.3317@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 21 Aug 2005, Chuck Ebbert wrote:
> 
>>>MATH ERROR: cwd = 0x37f, swd = 0x2800     <===========
>>
>> The error I marked has no exception flags set.  The rest are all (masked)
>>denormal exceptions.  Why your Cyrix MII would cause an FPU exception in these
>>cases is beyond me.  Could you try the statically-linked mprime program?

I use only the statically linked mprime.

> Also, please try this one, to see where it happens.
I did some modification to the code so it calls show_regs() in both 
cases where I get problems and also added the return so it does not 
crash. The code looks like this:
---
         printk("MATH ERROR: cwd = 0x%hx, swd = 0x%hx\n", cwd, swd);
         switch (((~cwd) & swd & 0x3f) | (swd & 0x240)) {
                 case 0x000:
                 case 0x200:
                         show_regs(regs);
                         return;
---
Here are the results.

MATH ERROR: cwd = 0x37f, swd = 0x1820

Pid: 1699, comm:               mprime
EIP: 0073:[<08181c73>] CPU: 0
EIP is at 0x8181c73
  ESP: 007b:bf927ab4 EFLAGS: 00010202    Not tainted  (2.6.12-pentium)
EAX: 00000001 EBX: 00000000 ECX: 0000808d EDX: b7f09480
ESI: b7455340 EDI: 080e01f0 EBP: bf927bf8 DS: 007b ES: 007b
CR0: 8005003b CR2: b7ed6058 CR3: 006f0000 CR4: 00000080
MATH ERROR: cwd = 0x37f, swd = 0x1020

Pid: 1699, comm:               mprime
EIP: 0073:[<0818ca5f>] CPU: 0
EIP is at 0x818ca5f
  ESP: 007b:bf927ab0 EFLAGS: 00010207    Not tainted  (2.6.12-pentium)
EAX: 00000005 EBX: 00000000 ECX: 00008407 EDX: b7f08140
ESI: b789aea0 EDI: b7f08200 EBP: bf927bf8 DS: 007b ES: 007b
CR0: 8005003b CR2: b75c6000 CR3: 006f0000 CR4: 00000080
MATH ERROR: cwd = 0x37f, swd = 0x2820

Pid: 1699, comm:               mprime
EIP: 0073:[<0818c4b1>] CPU: 0
EIP is at 0x818c4b1
  ESP: 007b:bf927ab0 EFLAGS: 00010247    Not tainted  (2.6.12-pentium)
EAX: 00000000 EBX: 00000000 ECX: 0000880f EDX: b7f09480
ESI: b741fc20 EDI: 080e0160 EBP: bf927bf8 DS: 007b ES: 007b
CR0: 8005003b CR2: b75c6000 CR3: 006f0000 CR4: 00000080
MATH ERROR: cwd = 0x37f, swd = 0x20

Pid: 1699, comm:               mprime
EIP: 0073:[<08181ca1>] CPU: 0
EIP is at 0x8181ca1
  ESP: 007b:bf927ab4 EFLAGS: 00010202    Not tainted  (2.6.12-pentium)
EAX: 00000002 EBX: 00000000 ECX: 00000084 EDX: b7f09480
ESI: b74f86c0 EDI: 080e01f0 EBP: bf927bf8 DS: 007b ES: 007b
CR0: 8005003b CR2: b75c6000 CR3: 006f0000 CR4: 00000080
MATH ERROR: cwd = 0x37f, swd = 0x1a20

Pid: 1699, comm:               mprime
EIP: 0073:[<08193c68>] CPU: 0
EIP is at 0x8193c68
  ESP: 007b:bf927ab8 EFLAGS: 00010206    Not tainted  (2.6.12-pentium)
EAX: 00000042 EBX: 00000000 ECX: 00154306 EDX: b7e3ba40
ESI: b7a1e680 EDI: b7e3be40 EBP: bf927bf8 DS: 007b ES: 007b
CR0: 8005003b CR2: b7499000 CR3: 006f0000 CR4: 00000080

MATH ERROR: cwd = 0x37f, swd = 0x20

Pid: 1699, comm:               mprime
EIP: 0073:[<0818de05>] CPU: 0
EIP is at 0x818de05
  ESP: 007b:bf927ab4 EFLAGS: 00010247    Not tainted  (2.6.12-pentium)
EAX: 00000004 EBX: 00000000 ECX: 0000880f EDX: b7f06b40
ESI: b7426400 EDI: 080e1960 EBP: bf927bf8 DS: 007b ES: 007b
CR0: 8005003b CR2: b7499000 CR3: 006f0000 CR4: 00000080
MATH ERROR: cwd = 0x37f, swd = 0x20

Pid: 1699, comm:               mprime
EIP: 0073:[<0818dfe4>] CPU: 0
EIP is at 0x818dfe4
  ESP: 007b:bf927ab4 EFLAGS: 00010247    Not tainted  (2.6.12-pentium)
EAX: 00000200 EBX: 00000000 ECX: 0000880f EDX: b7f06b40
ESI: b742a680 EDI: 080e1c60 EBP: bf927bf8 DS: 007b ES: 007b
CR0: 8005003b CR2: b7499000 CR3: 006f0000 CR4: 00000080

-- 
Ondrej Zary
