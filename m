Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbSITOUD>; Fri, 20 Sep 2002 10:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbSITOUD>; Fri, 20 Sep 2002 10:20:03 -0400
Received: from host.alias.fr ([62.23.174.163]:21776 "EHLO host.alias.fr")
	by vger.kernel.org with ESMTP id <S262658AbSITOUB>;
	Fri, 20 Sep 2002 10:20:01 -0400
Date: Fri, 20 Sep 2002 16:24:58 +0200 (CEST)
From: Pierrick Hascoet <pierrick.hascoet@hydromel.net>
X-X-Sender: pierrick@host.alias.fr
To: linux-kernel@vger.kernel.org
Subject: cpufreq oops with 2.4.20-pre7-ac3
Message-ID: <Pine.LNX.4.44.0209201534170.21037-100000@host.alias.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I caught an oops during the 2.4.20-pre7-ac3 boot sequence, this is related
to the last cpufreq update i guess, it's probably not an ac3 issue. The
cause it's a divide per 0 during cpufreq scaling.

The patch introduced here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103001001119668&w=2
must be aware of the div per 0 possible case.

OTOH, I can reproduce it only when laptop boot with ac power on, so with a
866 cpu frequency, scaled by cpufreq.

Best regards,
Pierrick.


Laptop: Compaq Evo N600c with ICH3-M chipset.

model name      : Intel(R) Pentium(R) III Mobile CPU       866MHz
stepping        : 1
cpu MHz         : 664.460

batz:~# ksymoops --vmlinux=/usr/src/linux-2.4.20-pre7-ac3/vmlinux
--system-map=/usr/src/linux-2.4.20-pre7-ac3/System.map  --no-ksyms
--no-lsmod < cpufreq.oops.txt
ksymoops 2.4.5 on i686 2.4.20-pre1-ac3.  Options used
     -v /usr/src/linux-2.4.20-pre7-ac3/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.20-pre1-ac3/ (default)
     -m /usr/src/linux-2.4.20-pre7-ac3/System.map (specified)

No modules in ksyms, skipping objects
CPU:    0
EIP:    0010:[<c010b413>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 004bde9c   ebx: 004bde9c     ecx: 00000000       edx: 00000000
esi: 00000000   edi: c11bbfa8     ebp: 000021c5       esp: c11bbf20
ds: 0018   es: 0018   0018
Process swapper (pid: 1, stackpage=c11bb000)
Stack: c02227a0 c11bbfa8 00000001 c0223fb4 00000097 00000246 c11b4800 c11bbfa8
       c011edee c02227a0 00000001 c11bbfa8 00000000 c11bbfa8 000021c5 c012233c
       c027aad8 00000001 c11bbfa8 c11bbf00 00000001 c11bbfa8 00001001 00000000
Call Trace:    [<c011edee>] [<c012233c>] [<c0111b65>] [<c0111ea8>] [<c0105023>]
  [<c01054e8>]
Code: f7 f1 89 c3 0f af dd 89 d6 0f af f5 89 f0 31 d2 f7 f1 01 d8


>>EIP; c010b413 <time_cpufreq_notifier+167/204>   <=====

>>EIP; c010b413 <time_cpufreq_notifier+167/204>   <=====

>>eax; 004bde9c Before first symbol
>>ebx; 004bde9c Before first symbol
>>edi; c11bbfa8 <END_OF_CODE+f1d0f4/????>
>>ebp; 000021c5 Before first symbol
>>esp; c11bbf20 <END_OF_CODE+f1d06c/????>

Trace; c011edee <notifier_call_chain+1e/38>
Trace; c012233c <cpufreq_notify_transition+ec/104>
Trace; c0111b65 <speedstep_set_state+15d/168>
Trace; c0111ea8 <speedstep_detect_speeds+80/b8>
Trace; c0105023 <init+7/114>
Trace; c01054e8 <kernel_thread+28/38>

Code;  c010b413 <time_cpufreq_notifier+167/204>
00000000 <_EIP>:
Code;  c010b413 <time_cpufreq_notifier+167/204>   <=====
   0:   f7 f1                     div    %ecx   <=====
Code;  c010b415 <time_cpufreq_notifier+169/204>
   2:   89 c3                     mov    %eax,%ebx
Code;  c010b417 <time_cpufreq_notifier+16b/204>
   4:   0f af dd                  imul   %ebp,%ebx
Code;  c010b41a <time_cpufreq_notifier+16e/204>
   7:   89 d6                     mov    %edx,%esi
Code;  c010b41c <time_cpufreq_notifier+170/204>
   9:   0f af f5                  imul   %ebp,%esi
Code;  c010b41f <time_cpufreq_notifier+173/204>
   c:   89 f0                     mov    %esi,%eax
Code;  c010b421 <time_cpufreq_notifier+175/204>
   e:   31 d2                     xor    %edx,%edx
Code;  c010b423 <time_cpufreq_notifier+177/204>
  10:   f7 f1                     div    %ecx
Code;  c010b425 <time_cpufreq_notifier+179/204>
  12:   01 d8                     add    %ebx,%eax

