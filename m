Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTLBHL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 02:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTLBHL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 02:11:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17856 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261575AbTLBHLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 02:11:50 -0500
Date: Tue, 2 Dec 2003 12:41:13 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Mike Gorse <mgorse@mgorse.dhs.org>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Oops w/sysfs when closing a disconnected usb serial device
Message-ID: <20031202071112.GA20864@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org> <20031201093804.GA6918@in.ibm.com> <Pine.LNX.4.58.0312011849050.9617@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312011849050.9617@mgorse.dhs.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

I think now I understand the problem better. It looks to me a case of
parent kobject going away before child. 

As we have 

> sysfs 1-1: removing dir
>  o 1-1:1.0 (10): <7>removing<7> done

and then
> sysfs 1-1:1.0: removing dir

Its good that you enabled debug printks. We can see error 

> usb 1-1: hcd_unlink_urb d3d33f60 fail -22

I think Greg or Pat can help you better in this case. I have no idea if 
this error is creating this problem.

Regards,
Maneesh

On Mon, Dec 01, 2003 at 06:55:38PM -0500, Mike Gorse wrote:
> Hi Maneesh,
> 
> On Mon, 1 Dec 2003, Maneesh Soni wrote:
> 
> > IMO d->d_inode is not expected to be NULL at this point. The only
> > place it can become NULL is in d_delete(d) call, but as the dentry ref.
> > count will be atleast 2, even this will not make d_inode NULL and it should
> > only unhash the dentry. Probably it will become more clear if you post
> > the oops message.
> > 
> It is trying to delete a directory which is gone already.  I'll post the 
> oops below.
> 
> > Mean while, I think kobject_del should not remove corresponding sysfs directory
> > until all the other references to kobject has gone. There can be references
> > taken in sysfs_open_file() from user space. The following patch moves the  
> > sysfs_remove_dir() call, to kobject_cleanup() and I think it may solve your 
> > problem also. It will be nice if you can test it.
> > 
> I wish your patch solved things in itself, but, without the added sysfs 
> check, I now get a new oops when disconnecting the device, even if no 
> applications are using it.
> 
> -- original oops (new oops below this one)--
> Unable to handle kernel NULL pointer dereference at virtual address 00000024
>  printing eip:
> c0175f95
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c0175f95>]    Not tainted
> EFLAGS: 00010202
> EIP is at simple_rmdir+0x35/0x50
> eax: 00000000   ebx: cbcae620   ecx: cbcae628   edx: ffffffd9
> esi: cbc865e0   edi: cfe56000   ebp: cbcae63c   esp: cfe57e30
> ds: 007b   es: 007b   ss: 0068
> Process gpsd (pid: 6012, threadinfo=cfe56000 task=d1766100)
> Stack: cbcae620 cbc50320 cbcc6320 cbcae620 c018f1ec cbc865e0 cbcae620 cbcae580 
>        cbcae620 c018f2dd cbcae620 cbcae580 cfe56000 d0fcaaa0 d0fcaecc d24b49a0 
>        00000000 c01edfe3 d0fcaaa0 c03ac8a0 d0fcaaa0 d0fcaa78 c02323c0 d0fcaaa0 
> Call Trace:
>  [<c018f1ec>] remove_dir+0x4c/0x70
>  [<c018f2dd>] sysfs_remove_dir+0xbd/0x130
>  [<c01edfe3>] kobject_del+0x43/0x80
>  [<c02323c0>] device_del+0x70/0xa0
>  [<c0232403>] device_unregister+0x13/0x30
>  [<d4977531>] destroy_serial+0x1a1/0x1e0 [usbserial]
>  [<d4976c5e>] serial_set_termios+0xbe/0x110 [usbserial]
>  [<c01ee125>] kobject_cleanup+0x85/0x90
>  [<d49764b0>] serial_close+0x90/0xf0 [usbserial]
>  [<c021e7b9>] release_dev+0x709/0x760
>  [<c0223a95>] set_termios+0xd5/0x1a0
>  [<c021ebda>] tty_release+0x2a/0x70
>  [<c015714a>] __fput+0x10a/0x120
>  [<c0155769>] filp_close+0x59/0x90
>  [<c0155802>] sys_close+0x62/0xa0
>  [<c010b4db>] syscall_call+0x7/0xb
> 
> Code: ff 48 24 89 5c 24 04 89 34 24 e8 9c ff ff ff ff 4e 24 31 d2 
>  
> --new oops--
> hub 1-0:1.0: port 1, status 100, change 3, 12 Mb/s
> usb 1-1: USB disconnect, address 2
> usb 1-1: usb_disable_device nuking all URBs
> usb 1-1: unregistering interface 1-1:1.0
> drivers/usb/serial/usb-serial.c: usb_serial_disconnect
> drivers/usb/serial/usb-serial.c: destroy_serial - 
> drivers/usb/serial/usb-serial.c: serial_shutdown
> drivers/usb/serial/ftdi_sio.c: ftdi_shutdown
> drivers/usb/serial/usb-serial.c: return_serial
> sysfs ttyUSB0: removing dir
>  o dev (1): <7>removing<7> done
>  o ttyUSB0 removing done (1)
> FTDI 8U232AM Compatible ttyUSB0: FTDI 8U232AM Compatible converter now disconnected from ttyUSB0
>  o power removing done (1)
> sysfs ttyUSB0: removing dir
>  o power (1): <7>removing<7> done
>  o detach_state (1): <7>removing<7> done
>  o ttyUSB0 removing done (1)
> drivers/usb/serial/usb-serial.c: port_release - ttyUSB0
> usb 1-1: hcd_unlink_urb d3d33f60 fail -22
> usbserial 1-1:1.0: device disconnected
>  o power removing done (1)
> drivers/usb/core/usb.c: usb_hotplug
> usb 1-1: unregistering device
>  o power removing done (1)
> drivers/usb/core/usb.c: usb_hotplug
> sysfs 1-1: removing dir
>  o 1-1:1.0 (10): <7>removing<7> done
>  o product (1): <7>removing<7> done
>  o manufacturer (1): <7>removing<7> done
>  o speed (1): <7>removing<7> done
>  o bNumConfigurations (1): <7>removing<7> done
>  o bDeviceProtocol (1): <7>removing<7> done
>  o bDeviceSubClass (1): <7>removing<7> done
>  o bDeviceClass (1): <7>removing<7> done
>  o bcdDevice (1): <7>removing<7> done
>  o idProduct (1): <7>removing<7> done
>  o idVendor (1): <7>removing<7> done
>  o bMaxPower (1): <7>removing<7> done
>  o bmAttributes (1): <7>removing<7> done
>  o bConfigurationValue (1): <7>removing<7> done
>  o bNumInterfaces (1): <7>removing<7> done
>  o power (1): <7>removing<7> done
>  o detach_state (1): <7>removing<7> done
>  o 1-1 removing done (2)
> sysfs 1-1:1.0: removing dir
>  o iInterface (1): <7>removing<7> done
>  o bInterfaceProtocol (1): <7>removing<7> done
>  o bInterfaceSubClass (1): <7>removing<7> done
>  o bInterfaceClass (1): <7>removing<7> done
>  o bNumEndpoints (1): <7>removing<7> done
>  o bAlternateSetting (1): <7>removing<7> done
>  o bInterfaceNumber (1): <7>removing<7> done
>  o power (1): <7>removing<7> done
>  o detach_state (1): <7>removing<7> done
> Unable to handle kernel NULL pointer dereference at virtual address 00000024
>  printing eip:
> c0174b03
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c0174b03>]    Not tainted
> EFLAGS: 00010202
> EIP is at simple_rmdir+0x33/0x50
> eax: 00000000   ebx: d3d0d5a0   ecx: 00000001   edx: ffffffd9
> esi: d3d49780   edi: d3df0000   ebp: d3df1e68   esp: d3df1e58
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 5, threadinfo=d3df0000 task=c133a040)
> Stack: d3d0d5a0 d3d0aa00 d3d4b6c0 d3d0d5a0 d3df1e84 c018d69c d3d49780 d3d0d5a0 
>        d3d0d500 d3d0d500 d3d0d5a0 d3df1eac c018d7e4 d3d0d5a0 d3d0d500 00000001 
>        d3d0d5bc d3df0000 d3d60d1c c03c5b30 c03c5b60 d3df1ec4 c01ea9cd d3d60d1c 
> Call Trace:
>  [<c018d69c>] remove_dir+0x4c/0x90
>  [<c018d7e4>] sysfs_remove_dir+0xf4/0x170
>  [<c01ea9cd>] kobject_cleanup+0x2d/0x80
>  [<c0280983>] usb_destroy_configuration+0xc3/0x110
>  [<c0278c02>] usb_release_dev+0x32/0x60
>  [<c022e771>] device_release+0x21/0x80
>  [<c01eaa1c>] kobject_cleanup+0x7c/0x80
>  [<c027be3f>] hub_port_connect_change+0x38f/0x3a0
>  [<c027c28f>] hub_events+0x43f/0x4d0
>  [<c027c355>] hub_thread+0x35/0x110
>  [<c011d940>] default_wake_function+0x0/0x20
>  [<c027c320>] hub_thread+0x0/0x110
>  [<c01092d9>] kernel_thread_helper+0x5/0xc
> 
> Code: ff 48 24 89 5c 24 04 89 34 24 e8 9e ff ff ff ff 4e 24 31 d2 

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
