Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbVDHPqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbVDHPqD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 11:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVDHPqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 11:46:03 -0400
Received: from twister.ispgateway.de ([80.67.18.17]:39576 "EHLO
	twister.ispgateway.de") by vger.kernel.org with ESMTP
	id S262855AbVDHPp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 11:45:27 -0400
Date: Fri, 8 Apr 2005 17:46:38 +0200
From: Steffen Moser <lists@steffen-moser.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with "linux-2.4.29"
Message-ID: <20050408154638.GA4641@steffen-moser.de>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20050331132449.GO10495@steffen-moser.de> <20050403202018.GB26531@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403202018.GB26531@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

* On Sun, Apr 03, 2005 at 05:20 PM (-0300), Marcelo Tosatti wrote:

> This looks like corruption - ext3_get_block() jumps to a bogus function
> which contains bogus instructions. Like if ext3_get_block() had been
> overwritten with junk data. 

Thank you very much for your quick reply! 

> Smells like bad hardware, but I'm not certain.
>
> > [6.] A small shell script or example program which triggers the
> > problem (if possible):
> > 
> > Running "antivir /usr/lib/AntiVir/antivir -s -e -del /home /export"
> > every two hours (started by "cron") will produce a oops like this
> > within a few days.
> 
> Do you have other oopses saved? Please send em.

Today, I (finally) got some oopses a few hours after I had started a 
little file system stress tesing running a few "antivir" instances 
(but I had done this also the last days beginning when your reply 
received me). 

I am still running "linux-2.4.29" on this machine. 

I've put the oopses on to my web space:

  http://www.uni-ulm.de/~s_smoser/ml/lkml/2005-04-08_01/fsa01_2005-05-08_oopses-syslog.log

The call trace addresses were already resolved to symbols by "klogd" 
(I didn't start using "-x"). Therefore I looked into the kernel ring 
buffer using "dmesg", but unfortunately I didn't get all oopses from 
there (especially the first one wasn't there anymore). Nevertheless, 
I also put up the (incomplete) oopses which I extracted from "dmesg":

  http://www.uni-ulm.de/~s_smoser/ml/lkml/2005-04-08_01/fsa01_2005-05-08_oopses-dmesg.log

I haven't rebooted the machine, yet (and I don't have to reboot be-
fore Monday). If I should do further testing, please let me know. 

Today, all of the running "antivir" processes were terminated with a 
segmentation fault. The last time when the machine oopsed (2005-03-31), 
they just stuck. Last time, I also didn't get "Unable to handle kernel 
paging request at virtual address" (as it happened today), but an "Un-
able to handle kernel NULL pointer dereference" instead.

By the way (but it isn't very surprising): After today's oopses I can
easily produce more oopses by simply accessing the file:

  /home/s00469/.seyon/protocols

(I saw that this file was the last one that was accessed by the anti-
vir processes before they segfaulted).

For example:

 | strace cat /home/s00469/.seyon/protocols

gives the a SIGSEV (of, course, also without doing "strace"):

 | [...]
 |
 | open("/usr/lib/locale/en_US/LC_CTYPE", O_RDONLY) = 3
 | fstat64(3, {st_mode=S_IFREG|0644, st_size=110304, ...}) = 0
 | old_mmap(NULL, 110304, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4013d000
 | close(3)                                = 0
 | fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 2), ...}) = 0
 | open("/home/s00469/.seyon/protocols", O_RDONLY|O_LARGEFILE) = 3
 | fstat64(3, {st_mode=S_IFREG|0644, st_size=2113, ...}) = 0
 | brk(0x8050000)                          = 0x8050000
 | read(3,  <unfinished ...>
 | +++ killed by SIGSEGV +++

and produces two further oopses:

 | Unable to handle kernel paging request at virtual address 14d8d3a9
 | c0124141
 | *pde = 00000000
 | Oops: 0002
 | CPU:    0
 | EIP:    0010:[<c0124141>]    Not tainted
 | Using defaults from ksymoops -t elf32-i386 -a i386
 | EFLAGS: 00010202
 | eax: 14d8d3a5   ebx: c1022fe8   ecx: 00000000   edx: 00000cb9
 | esi: dfec1178   edi: c1022fe8   ebp: d8d3a511   esp: ccfc3f34
 | ds: 0018   es: 0018   ss: 0018
 | Process cat (pid: 15412, stackpage=ccfc3000)
 | Stack: 00000000 dad358c0 0804dac8 dad358e0 00001000 00000001 00000000 00000000
 |        d2000000 c0124593 dad358c0 dad358e0 ccfc3f8c c012447c 00000000 dad358c0
 |        ffffffea 00001000 c0111f5d ccfc3fac ccfc2000 00000000 00000000 00001000
 | Call Trace:    [<c0124593>] [<c012447c>] [<c0111f5d>] [<c0130d66>] [<c0106b9f>]
 | Code: 89 78 04 89 07 89 6f 04 89 7d 00 89 6f 08 89 f2 89 f8 e8 b8
 | 
 | 
 | >>EIP; c0124141 <do_generic_file_read+381/438>   <=====
 | 
 | >>ebx; c1022fe8 <_end+d31ad4/20552aec>
 | >>esi; dfec1178 <_end+1fbcfc64/20552aec>
 | >>edi; c1022fe8 <_end+d31ad4/20552aec>
 | >>ebp; d8d3a511 <_end+18a48ffd/20552aec>
 | >>esp; ccfc3f34 <_end+ccd2a20/20552aec>
 | 
 | Trace; c0124593 <generic_file_read+8b/190>
 | Trace; c012447c <file_read_actor+0/8c>
 | Trace; c0111f5d <schedule+2d1/2f8>
 | Trace; c0130d66 <sys_read+96/f0>
 | Trace; c0106b9f <tracesys+1f/23>
 | 
 | Code;  c0124141 <do_generic_file_read+381/438>
 | 00000000 <_EIP>:
 | Code;  c0124141 <do_generic_file_read+381/438>   <=====
 |    0:   89 78 04                  mov    %edi,0x4(%eax)   <=====
 | Code;  c0124144 <do_generic_file_read+384/438>
 |    3:   89 07                     mov    %eax,(%edi)
 | Code;  c0124146 <do_generic_file_read+386/438>
 |    5:   89 6f 04                  mov    %ebp,0x4(%edi)
 | Code;  c0124149 <do_generic_file_read+389/438>
 |    8:   89 7d 00                  mov    %edi,0x0(%ebp)
 | Code;  c012414c <do_generic_file_read+38c/438>
 |    b:   89 6f 08                  mov    %ebp,0x8(%edi)
 | Code;  c012414f <do_generic_file_read+38f/438>
 |    e:   89 f2                     mov    %esi,%edx
 | Code;  c0124151 <do_generic_file_read+391/438>
 |   10:   89 f8                     mov    %edi,%eax
 | Code;  c0124153 <do_generic_file_read+393/438>
 |   12:   e8 b8 00 00 00            call   cf <_EIP+0xcf> c0124210 <generic_file_direct_IO+18/284>
 | 
 |  <1>Unable to handle kernel paging request at virtual address 8800002c
 | c0141210
 | *pde = 00000000
 | Oops: 0000
 | CPU:    0
 | EIP:    0010:[<c0141210>]    Not tainted
 | EFLAGS: 00010286
 | eax: 88000000   ebx: dad358c0   ecx: 88000000   edx: d881b8fc
 | esi: 00000000   edi: d881b8fc   ebp: d938cdc0   esp: ccfc3dcc
 | ds: 0018   es: 0018   ss: 0018
 | Process cat (pid: 15412, stackpage=ccfc3000)
 | Stack: dad358c0 00000000 d938cdc0 00000001 c013090f dad358c0 d938cdc0 dad358c0
 |        d938cdc0 00000001 00000003 d938cdc0 c0116bb8 dad358c0 d938cdc0 de620d20
 |        ccfc3f00 ccfc2000 0000000b d938cedc c011714f d938cdc0 00000002 ccfc3f00
 | Call Trace:    [<c013090f>] [<c0116bb8>] [<c011714f>] [<c01070f6>] [<c01112c7>]
 |   [<c0110f24>] [<c012ad46>] [<c012133b>] [<c0121387>] [<c0106c24>] [<c0124141>]
 |   [<c0124593>] [<c012447c>] [<c0111f5d>] [<c0130d66>] [<c0106b9f>] 
 | Code: f6 40 2c 01 0f 84 06 01 00 00 39 68 14 0f 85 fd 00 00 00 8b
 | 
 | 
 | >>EIP; c0141210 <locks_remove_posix+30/158>   <=====
 | 
 | >>ebx; dad358c0 <_end+1aa443ac/20552aec>
 | >>edx; d881b8fc <_end+1852a3e8/20552aec>
 | >>edi; d881b8fc <_end+1852a3e8/20552aec>
 | >>ebp; d938cdc0 <_end+1909b8ac/20552aec>
 | >>esp; ccfc3dcc <_end+ccd28b8/20552aec>
 | 
 | Trace; c013090f <filp_close+4b/5c>
 | Trace; c0116bb8 <put_files_struct+54/bc>
 | Trace; c011714f <do_exit+ab/234>
 | Trace; c01070f6 <die+56/58>
 | Trace; c01112c7 <do_page_fault+3a3/4d4>
 | Trace; c0110f24 <do_page_fault+0/4d4>
 | Trace; c012ad46 <_alloc_pages+16/18>
 | Trace; c012133b <do_anonymous_page+c3/dc>
 | Trace; c0121387 <do_no_page+33/188>
 | Trace; c0106c24 <error_code+34/3c>
 | Trace; c0124141 <do_generic_file_read+381/438>
 | Trace; c0124593 <generic_file_read+8b/190>
 | Trace; c012447c <file_read_actor+0/8c>
 | Trace; c0111f5d <schedule+2d1/2f8>
 | Trace; c0130d66 <sys_read+96/f0>
 | Trace; c0106b9f <tracesys+1f/23>
 | 
 | Code;  c0141210 <locks_remove_posix+30/158>
 | 00000000 <_EIP>:
 | Code;  c0141210 <locks_remove_posix+30/158>   <=====
 |    0:   f6 40 2c 01               testb  $0x1,0x2c(%eax)   <=====
 | Code;  c0141214 <locks_remove_posix+34/158>
 |    4:   0f 84 06 01 00 00         je     110 <_EIP+0x110> c0141320 <locks_remove_posix+140/158>
 | Code;  c014121a <locks_remove_posix+3a/158>
 |    a:   39 68 14                  cmp    %ebp,0x14(%eax)
 | Code;  c014121d <locks_remove_posix+3d/158>
 |    d:   0f 85 fd 00 00 00         jne    110 <_EIP+0x110> c0141320 <locks_remove_posix+140/158>
 | Code;  c0141223 <locks_remove_posix+43/158>
 |   13:   8b 00                     mov    (%eax),%eax

I can repeat it as often as I want, but I don't think that this delivers
something new - the system is in a unstable state since the first oops 
has occured today at 12:03:22. 

The system's uptime is now: 2 days, 16:19. 

I've also found some older oopses that I didn't post last time. I haven't 
resolved them by "ksymoops" when they appeared, but they were resolved by 
"klogd" a bit (I don't have the symbol file from there anymore). I also 
uploaded them to my web space, you'll find them there:

  http://www.uni-ulm.de/~s_smoser/ml/lkml/2005-04-08_01/fsa01_2005-03-22_oopses-syslog.log

All in all it seems that the parts where the oopses occur and how they
occur are varying quite, so I suppose that hardware problems are really
very, very likely. 

Perhaps there is a link to these old SCSI errors:

  http://www.uni-ulm.de/~s_smoser/ml/lkml/2003-11-09_01/logs/
  (already posted in my last mail)

One thing the oopses have in common: A high I/O load on the SCSI system 
seems to provoke them. High SCSI load is mainly caused by "antivir" or 
by "smbd" (Samba) on this machine. These days I used "antivir" to pro-
voke the oopses. I don't have oopsed caused by "smbd" (this happened in 
February, IIRC) anymore.

Thank you very much for your analyzing!

Best regards,
Steffen
