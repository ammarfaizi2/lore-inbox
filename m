Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288854AbSAIGEt>; Wed, 9 Jan 2002 01:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288853AbSAIGEj>; Wed, 9 Jan 2002 01:04:39 -0500
Received: from node10450.a2000.nl ([24.132.4.80]:896 "EHLO awacs.dhs.org")
	by vger.kernel.org with ESMTP id <S288854AbSAIGE2>;
	Wed, 9 Jan 2002 01:04:28 -0500
Date: Wed, 9 Jan 2002 07:04:27 +0100
From: Pascal Haakmat <a.haakmat@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 Oopses under load in __wake_up 
Message-ID: <20020109070427.A803@awacs.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a few Oopses under load on a 2.4.16 SMP kernel with XFS and low
latency patches. Although the virtual consoles appear to be dead (that is,
there is no video; I can switch to them and log in), the system is still
running, and I can still start X (with video) and log in via ssh to type
this [shortly before I tried to send this message, the machine locked up
solid after all; /var/log/messages shows 3 more Oopses in __wake_up preceded
by an Oops in poll_freewait before everything goes dark].

I have absolutely no idea what any of this means, probably it's already
fixed or just user error, but these Oopses are very similar to another
recent Oops that was reported on lkml (which got no replies):

http://linux-kernel.skylab.org/20011125/msg02034.html


*** Software:

- Running 'while true; do nmap 192.168.1.1; done' from another machine,
  to fake some semblance of network activity.
  
- Running 'while true; do ossrecord test.wav & sleep 5; kill $!; done'
  to fake some semblance of audio/file I/O.

- Running the following program to fake a bit of memory pressure:

#include <unistd.h>
void main() {
   int s=1024*1024*600;
   int c=1024;
   int i,j;
   char *p;
   for(j=0; j<c; j++) {
      printf("%d: grabbing %d bytes...\n",j,s);
      p=(char *)malloc(s);
      for(i=0; i<s; i+=1024)
	p[i]=2;
      printf("%d: sleeping...\n",j,s);
      sleep(10);
      free(p);
   }
}


*** Hardware:

600MHz dual PIII, SuperMicro P6DGU 440GX board w/AIC7890, 512MB of RAM,
three IDE disks and SCSI CDROM + CDRW. I've selected MPS 1.1 in the BIOS
because with MPS 1.4 the machine locks up hard after some use (perhaps this
will turn out to be the case with MPS 1.1 as well, but it _seems_ better).


*** Oops #1:

ksymoops 2.3.4 on i686 2.4.16-xfs-ll.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16-xfs-ll/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
Jan  9 05:12:32 awacs kernel: Unable to handle kernel paging request at virtual address 00026200
Jan  9 05:12:53 awacs kernel: c0113a53
Jan  9 05:12:53 awacs kernel: *pde = 00000000
Jan  9 05:12:53 awacs kernel: Oops: 0000
Jan  9 05:12:53 awacs kernel: CPU:    0
Jan  9 05:12:53 awacs kernel: EIP:    0010:[__wake_up+67/208]    Not tainted
Jan  9 05:12:53 awacs kernel: EFLAGS: 00010087
Jan  9 05:12:53 awacs kernel: eax: dbc3e980   ebx: c0325044   ecx: 00026200   edx: 00000001
Jan  9 05:12:53 awacs kernel: esi: dbc3e984   edi: dbc3e980   ebp: c748ddbc   esp: c748dd9c
Jan  9 05:12:53 awacs kernel: ds: 0018   es: 0018   ss: 0018
Jan  9 05:12:53 awacs kernel: Process ossrecord (pid: 19479, stackpage=c748d000)
Jan  9 05:12:53 awacs kernel: Stack: dbc3e000 c748dedf dbc3e980 00000000 dbc3e984 00000001 00000282 00000001 
Jan  9 05:12:53 awacs kernel:        c748dedf c01e9410 dbc3d000 dbc3e000 00000017 00000017 00000202 c131ac80 
Jan  9 05:12:53 awacs kernel:        c0178e75 ddc04460 00000000 00000000 00001000 40019000 00000000 c748de30 
Jan  9 05:12:53 awacs kernel: Call Trace: [n_tty_receive_buf+3516/3580] [_pagebuf_file_write+365/552] [pty_write+296/308] [opost_block+401/416] [<e097a325>] 
Jan  9 05:12:53 awacs kernel:    [<e090a0d6>] [write_chan+336/500] [tty_write+546/648] [write_chan+0/500] [sys_write+146/200] [system_call+51/56] 
Jan  9 05:12:53 awacs kernel: Code: 8b 01 85 45 fc 74 67 31 c0 9c 8f 45 ec fa f0 fe 0d 00 04 33 
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; e090a0d6 <[soundbase]oss_audio_read+3a6/3f0>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 01                     mov    (%ecx),%eax
Code;  00000002 Before first symbol
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  00000005 Before first symbol
   5:   74 67                     je     6e <_EIP+0x6e> 0000006e Before first symbol
Code;  00000007 Before first symbol
   7:   31 c0                     xor    %eax,%eax
Code;  00000009 Before first symbol
   9:   9c                        pushf  
Code;  0000000a Before first symbol
   a:   8f 45 ec                  popl   0xffffffec(%ebp)
Code;  0000000d Before first symbol
   d:   fa                        cli    
Code;  0000000e Before first symbol
   e:   f0 fe 0d 00 04 33 00      lock decb 0x330400


*** Oops #2:

ksymoops 2.3.4 on i686 2.4.16-xfs-ll.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16-xfs-ll/ (default)
     -m /boot/System.map (specified)

Jan  9 05:13:31 awacs kernel: Unable to handle kernel paging request at virtual address fffe0d00
Jan  9 05:13:31 awacs kernel: c0113a53
Jan  9 05:13:31 awacs kernel: *pde = 00003063
Jan  9 05:13:31 awacs kernel: Oops: 0000
Jan  9 05:13:31 awacs kernel: CPU:    1
Jan  9 05:13:31 awacs kernel: EIP:    0010:[__wake_up+67/208]    Not tainted
Jan  9 05:13:31 awacs kernel: EFLAGS: 00013087
Jan  9 05:13:31 awacs kernel: eax: dbe6d75c   ebx: c0325014   ecx: fffe0d00   edx: 00000001
Jan  9 05:13:31 awacs kernel: esi: dbe6d760   edi: dbe6d75c   ebp: dd97de50   esp: dd97de30
Jan  9 05:13:31 awacs kernel: ds: 0018   es: 0018   ss: 0018
Jan  9 05:13:31 awacs kernel: Process X (pid: 802, stackpage=dd97d000)
Jan  9 05:13:31 awacs kernel: Stack: dbe6d75c df83f420 df83f474 df30a420 dbe6d760 00000001 00003286 00000001 
Jan  9 05:13:31 awacs kernel:        df30a420 c0245fe2 db7a7720 00000020 c027bdde df83f420 00000020 dbe2e780 
Jan  9 05:13:31 awacs kernel:        dd97deec c027bb80 dbe2e780 df83f420 00000000 df83f420 df83f760 00000000 
Jan  9 05:13:32 awacs kernel: Call Trace: [sock_def_readable+54/96] [unix_stream_sendmsg+606/804] [unix_stream_sendmsg+0/804] [sock_sendmsg+129/164] [unix_stream_sendmsg+0/804] [sock_readv_writev+140/152] [sock_writev+54/64] [do_readv_writev+391/600] [update_process_times+32/152] [sys_writev+65/84] [system_call+51/56] 
Jan  9 05:13:32 awacs kernel: Code: 8b 01 85 45 fc 74 67 31 c0 9c 8f 45 ec fa f0 fe 0d 00 04 33 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 01                     mov    (%ecx),%eax
Code;  00000002 Before first symbol
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  00000005 Before first symbol
   5:   74 67                     je     6e <_EIP+0x6e> 0000006e Before first symbol
Code;  00000007 Before first symbol
   7:   31 c0                     xor    %eax,%eax
Code;  00000009 Before first symbol
   9:   9c                        pushf  
Code;  0000000a Before first symbol
   a:   8f 45 ec                  popl   0xffffffec(%ebp)
Code;  0000000d Before first symbol
   d:   fa                        cli    
Code;  0000000e Before first symbol
   e:   f0 fe 0d 00 04 33 00      lock decb 0x330400


*** Oops #3:

ksymoops 2.3.4 on i686 2.4.16-xfs-ll.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16-xfs-ll/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
Jan  9 05:13:33 awacs kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan  9 05:13:34 awacs kernel: c0113a53
Jan  9 05:13:35 awacs kernel: *pde = 00000000
Jan  9 05:13:35 awacs kernel: Oops: 0000
Jan  9 05:13:36 awacs kernel: CPU:    0
Jan  9 05:13:36 awacs kernel: EIP:    0010:[__wake_up+67/208]    Not tainted
Jan  9 05:13:36 awacs kernel: EFLAGS: 00010083
Jan  9 05:13:36 awacs kernel: eax: dbcf6f3c   ebx: c032502c   ecx: 00000000   edx: 00000001
Jan  9 05:13:36 awacs kernel: esi: dbcf6f40   edi: dbcf6f3c   ebp: dd55fe50   esp: dd55fe30
Jan  9 05:13:36 awacs kernel: ds: 0018   es: 0018   ss: 0018
Jan  9 05:13:37 awacs kernel: Process gnome-session (pid: 806, stackpage=dd55f000)
Jan  9 05:13:37 awacs kernel: Stack: dbcf6f3c df83faa0 df844080 00000286 dbcf6f40 00000000 00000286 00000001 
Jan  9 05:13:37 awacs kernel:        c180df60 c0245f37 df83faa0 df8440d4 c027a436 df83faa0 dbcf6d40 dbcf6c20 
Jan  9 05:13:37 awacs kernel:        c180d1e0 dbea22e0 df83faa0 00000001 dd2079e0 c027a7de df844080 00000000 
Jan  9 05:13:37 awacs kernel: Call Trace: [sock_def_wakeup+51/64] [unix_release_sock+386/728] [unix_release+26/36] [sock_release+18/96] [sock_close+57/64] 
Jan  9 05:13:37 awacs kernel: Code: 8b 01 85 45 fc 74 67 31 c0 9c 8f 45 ec fa f0 fe 0d 00 04 33 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 01                     mov    (%ecx),%eax
Code;  00000002 Before first symbol
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  00000005 Before first symbol
   5:   74 67                     je     6e <_EIP+0x6e> 0000006e Before first symbol
Code;  00000007 Before first symbol
   7:   31 c0                     xor    %eax,%eax
Code;  00000009 Before first symbol
   9:   9c                        pushf  
Code;  0000000a Before first symbol
   a:   8f 45 ec                  popl   0xffffffec(%ebp)
Code;  0000000d Before first symbol
   d:   fa                        cli    
Code;  0000000e Before first symbol
   e:   f0 fe 0d 00 04 33 00      lock decb 0x330400


1 warning issued.  Results may not be reliable.

