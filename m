Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272008AbTG2TJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272006AbTG2TJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:09:56 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:50702
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272037AbTG2TJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:09:20 -0400
Date: Tue, 29 Jul 2003 12:00:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Greg KH <greg@kroah.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hotplug Oops Re: Linux v2.6.0-test1
Message-ID: <20030729190003.GA731@matchmail.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030718023141.GC5828@kroah.com> <20030729180209.GB1185@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729180209.GB1185@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 11:02:09AM -0700, Mike Fedyk wrote:
> On Thu, Jul 17, 2003 at 07:31:41PM -0700, Greg KH wrote:
> > On Wed, Jul 16, 2003 at 01:15:12PM -0700, Mike Fedyk wrote:
> > > Ok, I only see it when the system is booting, and after looking at the    
> > > hotplug script in init.d there is different behaviour on boot, and on later   
> > > invocations.                               
> > 
> > This is really wierd.  I can't see anything strange in your logs, until
> > the oops :)
> > 
> > I also can't duplicate it here myself, sorry, I don't really have any
> > ideas.
> 
> Ok, I was going through some of my logs, and I came across this one, which
> is a little different.
> 
> Maybe it will help some...

I have added "set -x" to the init scripts, and here is the output.

I'm not sure if it'll help, since it looks pretty normal to me (just a bunch
of variable changes and etc, nothing special).

/etc/init.d/hotplug:
+ PATH=/sbin:/bin:/usr/sbin:/usr/bin
+ test -x /sbin/hotplug
+ echo -n 'Starting hotplug subsystem:'
Starting hotplug subsystem:+ '[' S = S ']'
+ touch /etc/nohotplug
+ echo /sbin/hotplug
+ '[' S '!=' S ']'
+ basename=usb.rc
+ name=usb
+ echo -n ' usb'
 usb+ /etc/hotplug/usb.rc start


/etc/hotplug/usb.rc:
+ PATH=/sbin:/bin:/usr/sbin:/usr/bin
+ unset I_WANT_A_BROKEN_PS
+ PS_PERSONALITY=linux
+ STATIC_MODULE_LIST=
+ X11_USBMICE_HACK=false
+ '[' -f /etc/default/hotplug ']'
+ . /etc/default/hotplug
++ USBD_ENABLE=true
++ STATIC_MODULE_LIST=
++ X11_USBMICE_HACK=false
+ MOUSE_MODULES=mousedev input
+ '[' false = true ']'
+ maybe_start_usb
+ local COUNT SYNTHESIZE
+ COUNT=0
+ SYNTHESIZE=true
+ '[' '!' -d /proc/bus/usb ']'
+ modprobe -q usbcore
+ '[' -d /proc/bus/usb ']'
+ '[' '!' -f /proc/bus/usb/devices ']'
+ modprobe -q ehci-hcd
/etc/hotplug/usb.rc: line 382:   260 Segmentation fault      modprobe -q ehci-hcd >/dev/null 2>&1
+ modprobe -q ohci-hcd

Here is the kksymoops output:

Unable to handle kernel paging request at virtual address d494989c
 printing eip:
c01d7f7d
*pde = 040d0067
Oops: 0002 [#1]
PREEMPT SMP 
CPU:    0
EIP:    0060:[kobject_add+121/244]    Not tainted VLI
EFLAGS: 00010296
EIP is at kobject_add+0x79/0xf4
eax: c039b2c0   ebx: d495e144   ecx: d494989c   edx: d495e15c
esi: c039b2c8   edi: c039b264   ebp: d35c3f34   esp: d35c3f28
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 260, threadinfo=d35c2000 task=d35c5940)
Stack: d495e144 d495e144 00000000 d35c3f4c c01d8010 d495e144 d495e144 d495e144 
       c039b260 d35c3f70 c022574f d495e144 d495e144 d495cb0a 00000014 d495e100 
       00000000 d495e1a0 d35c3f7c c0225b0a d495e128 d35c3f94 c01de234 d495e128 
Call Trace:
 [kobject_register+24/72] kobject_register+0x18/0x48
 [bus_add_driver+63/140] bus_add_driver+0x3f/0x8c
 [driver_register+54/60] driver_register+0x36/0x3c
 [pci_register_driver+116/152] pci_register_driver+0x74/0x98
 [_end+340150886/1069206088] init+0x1e/0x4c [ehci_hcd]
 [sys_init_module+288/584] sys_init_module+0x120/0x248
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 00 85 f6 75 11 8b 43 24 83 c0 10 50 e8 81 01 00 00 89 c6 83 c4 04 8b 43 24 83 c0 08 8d 53 18 8b 48 04 89 50 04 89 43 18 89 4a 04 <89> 11 8b 43 24 8b 38 8d 4f 44 89 c8 ba ff ff 00 00 f0 0f c1 10 
 <7>ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : Kill All Tasks

Is ksymoops reliable with 2.6 kernels?  Its output is different...

ksymoops 2.4.8 on i686 2.6.0-test2-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test2-mm1/ (default)
     -m /boot/System.map-2.6.0-test2-mm1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address d494989c
c01d7f7d
*pde = 040d0067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[kobject_add+121/244]    Not tainted VLI
EFLAGS: 00010296
eax: c039b2c0   ebx: d495e144   ecx: d494989c   edx: d495e15c
esi: c039b2c8   edi: c039b264   ebp: d35c3f34   esp: d35c3f28
ds: 007b   es: 007b   ss: 0068
Stack: d495e144 d495e144 00000000 d35c3f4c c01d8010 d495e144 d495e144 d495e144 
       c039b260 d35c3f70 c022574f d495e144 d495e144 d495cb0a 00000014 d495e100 
       00000000 d495e1a0 d35c3f7c c0225b0a d495e128 d35c3f94 c01de234 d495e128 
Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>eax; c039b2c0 <pci_bus_type+60/ec>
>>ebx; d495e144 <_end+1450cb8c/3fbaca48>
>>ecx; d494989c <_end+144f82e4/3fbaca48>
>>edx; d495e15c <_end+1450cba4/3fbaca48>
>>esi; c039b2c8 <pci_bus_type+68/ec>
>>edi; c039b264 <pci_bus_type+4/ec>
>>ebp; d35c3f34 <_end+1317297c/3fbaca48>
>>esp; d35c3f28 <_end+13172970/3fbaca48>

Code: 00 85 f6 75 11 8b 43 24 83 c0 10 50 e8 81 01 00 00 89 c6 83 c4 04 8b 43 24 83 c0 08 8d 53 18 8b 48 04 89 50 04 89 43 18 89 4a 04 <89> 11 8b 43 24 8b 38 8d 4f 44 89 c8 ba ff ff 00 00 f0 0f c1 10 
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   00 85 f6 75 11 8b         add    %al,0x8b1175f6(%ebp)
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   43                        inc    %ebx
Code;  ffffffdc <__kernel_rt_sigreturn+1b9c/????>
   7:   24 83                     and    $0x83,%al
Code;  ffffffde <__kernel_rt_sigreturn+1b9e/????>
   9:   c0 10 50                  rclb   $0x50,(%eax)
Code;  ffffffe1 <__kernel_rt_sigreturn+1ba1/????>
   c:   e8 81 01 00 00            call   192 <_EIP+0x192>
Code;  ffffffe6 <__kernel_rt_sigreturn+1ba6/????>
  11:   89 c6                     mov    %eax,%esi
Code;  ffffffe8 <__kernel_rt_sigreturn+1ba8/????>
  13:   83 c4 04                  add    $0x4,%esp
Code;  ffffffeb <__kernel_rt_sigreturn+1bab/????>
  16:   8b 43 24                  mov    0x24(%ebx),%eax
Code;  ffffffee <__kernel_rt_sigreturn+1bae/????>
  19:   83 c0 08                  add    $0x8,%eax
Code;  fffffff1 <__kernel_rt_sigreturn+1bb1/????>
  1c:   8d 53 18                  lea    0x18(%ebx),%edx
Code;  fffffff4 <__kernel_rt_sigreturn+1bb4/????>
  1f:   8b 48 04                  mov    0x4(%eax),%ecx
Code;  fffffff7 <__kernel_rt_sigreturn+1bb7/????>
  22:   89 50 04                  mov    %edx,0x4(%eax)
Code;  fffffffa <__kernel_rt_sigreturn+1bba/????>
  25:   89 43 18                  mov    %eax,0x18(%ebx)
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  00000000 Before first symbol
  2b:   89 11                     mov    %edx,(%ecx)
Code;  00000002 Before first symbol
  2d:   8b 43 24                  mov    0x24(%ebx),%eax
Code;  00000005 Before first symbol
  30:   8b 38                     mov    (%eax),%edi
Code;  00000007 Before first symbol
  32:   8d 4f 44                  lea    0x44(%edi),%ecx
Code;  0000000a Before first symbol
  35:   89 c8                     mov    %ecx,%eax
Code;  0000000c Before first symbol
  37:   ba ff ff 00 00            mov    $0xffff,%edx
Code;  00000011 Before first symbol
  3c:   f0 0f c1 10               lock xadd %edx,(%eax)


2 warnings and 1 error issued.  Results may not be reliable.
