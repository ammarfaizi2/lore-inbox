Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbTCaHAF>; Mon, 31 Mar 2003 02:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261439AbTCaHAF>; Mon, 31 Mar 2003 02:00:05 -0500
Received: from snoopy.pacific.net.au ([61.8.0.36]:1732 "EHLO
	snoopy.pacific.net.au") by vger.kernel.org with ESMTP
	id <S261440AbTCaHAD>; Mon, 31 Mar 2003 02:00:03 -0500
Message-Id: <5.1.1.6.0.20030331163951.009f19e0@its2>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 31 Mar 2003 17:11:02 +1000
To: linux-kernel@vger.kernel.org
From: Anders Holmstrom <andersh@silcraft.com.au>
Subject: 2.4.18 timer list corruption
Cc: mhw@wittsend.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Return-Path: andersh@silcraft.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My first bug-report, hope I've got it right ... :-)

New AMD/Athlon server running Debian 3.0 (Woody/Stable).
The kernel in use came with the distro; I have not recompiled it.
One Computone IntelliportII with 2 boxes, each with 16 ports.
Produces a consistent Oops when putting some load on the intelliport (a 
single login running a file-transfer does it). Logging in via console or 
network does _not_ Oops. It has also produced several Oops at the end of 
boot-up, before any logins.

Keith Owens (ksymoops maintainer) has helped with interpretation.

The following command:
andersh@smacs:~/oops$ ksymoops -m /boot/System.map-2.4.18-bf2.4\
 >  -k /var/log/ksymoops/20030328062503.ksyms\
 >  -l /var/log/ksymoops/20030328062503.modules < oops.txt

produced this output:
ksymoops 2.4.5 on i686 2.4.18-bf2.4.  Options used
      -V (default)
      -k /var/log/ksymoops/20030328062503.ksyms (specified)
      -l /var/log/ksymoops/20030328062503.modules (specified)
      -o /lib/modules/2.4.18-bf2.4/ (default)
      -m /boot/System.map-2.4.18-bf2.4 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c011c345
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011c345>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: cc052c04   ebx: cc052c04   ecx: 00000002   edx: 00000000
esi: 00000000   edi: c9ab143e   ebp: 00000194   esp: ccfc5ea0
ds: 0018   es: 0018   ss: 0018
Process kermit (pid: 1341, stackpage=ccfc5000)
Stack: 00000004 d08bcff8 cc052c04 00000002 c9ab16f8 c9ab1444 00000194 00065ed4
        000003e6 00000082 000003e6 00011444 000003e7 00012800 d08bca23 cc052800
        c9ab0fd0 bffffb5a c9ab16f6 00000282 ccfc4000 0000000a 00000002 00020286
Call Trace: [<d08bcff8>] [<d08bca23>] [<d08bef31>] [<c01b04fd>] [<c01ac239>]
    [<c01b0364>] [<c0130035>] [<c0106d7b>]
Code: 89 5a 04 89 13 89 43 04 89 18 51 9d eb 13 51 9d ff 74 24 04


 >>EIP; c011c345 <add_timer+a5/c8>   <=====

 >>eax; cc052c04 <_end+bc78848/104bac44>
 >>ebx; cc052c04 <_end+bc78848/104bac44>
 >>edi; c9ab143e <_end+96d7082/104bac44>
 >>esp; ccfc5ea0 <_end+cbebae4/104bac44>

Trace; d08bcff8 <[ip2main]serviceOutgoingFifo+350/370>
Trace; d08bca23 <[ip2main]i2Output+25b/274>
Trace; d08bef31 <[ip2main]ip2_flush_chars+39/8c>
Trace; c01b04fd <write_chan+199/214>
Trace; c01ac239 <tty_write+191/200>
Trace; c01b0364 <write_chan+0/214>
Trace; c0130035 <sys_write+95/e0>
Trace; c0106d7b <system_call+33/38>

Code;  c011c345 <add_timer+a5/c8>
00000000 <_EIP>:
Code;  c011c345 <add_timer+a5/c8>   <=====
    0:   89 5a 04                  mov    %ebx,0x4(%edx)   <=====
Code;  c011c348 <add_timer+a8/c8>
    3:   89 13                     mov    %edx,(%ebx)
Code;  c011c34a <add_timer+aa/c8>
    5:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  c011c34d <add_timer+ad/c8>
    8:   89 18                     mov    %ebx,(%eax)
Code;  c011c34f <add_timer+af/c8>
    a:   51                        push   %ecx
Code;  c011c350 <add_timer+b0/c8>
    b:   9d                        popf
Code;  c011c351 <add_timer+b1/c8>
    c:   eb 13                     jmp    21 <_EIP+0x21> c011c366 
<add_timer+c6/c8>
Code;  c011c353 <add_timer+b3/c8>
    e:   51                        push   %ecx
Code;  c011c354 <add_timer+b4/c8>
    f:   9d                        popf
Code;  c011c355 <add_timer+b5/c8>
   10:   ff 74 24 04               pushl  0x4(%esp,1)
<end-of-ksymoops-output>

Here are Keith's comments:
The call sequence is
   drivers/char/ip2/i2lib.c:serviceOutgoingFifo() ->
     drivers/char/ip2/i2lib.c:iiSendPendingMail() ->
       kernel/timer.c:add_timer() ->
         kernel/timer.c:internal_add_timer() ->
           list_add(&timer->list, vec->prev);

vec is one of the tv1 entries.  vec->prev->next->prev is NULL.  This
should never happen, lists are double headed and double linked so all
pointers should be valid, something has corrupted the timer list.


 From /etc/modutils.conf:
### update-modules: start processing /etc/modutils/ip2
options ip2 io=1
alias char-major-71 ip2


And finally, here is the output from ver_linux:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux smacs 2.4.18-bf2.4 #1 Son Apr 14 09:53:28 CEST 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ip2 ip2main st tulip keybdev usbkbd usbcore input
<end-of-ver_linux-output>

Thank you for any and all help.

Regards,
Anders.


