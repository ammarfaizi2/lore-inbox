Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266088AbUAQSL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 13:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266090AbUAQSL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 13:11:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:42765 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266088AbUAQSLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 13:11:50 -0500
Date: Sat, 17 Jan 2004 19:11:26 +0100
From: Willy Tarreau <willy@w.ods.org>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Cc: davem@redhat.com, jgarzik@pobox.com
Subject: [2.4][TG3] deadlock between rmmod, SIOCDEVPRIVATE, SIOCETHTOOL
Message-ID: <20040117181126.GA669@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I have a problem with TG3 on any kernel from 2.4.21 to 2.4.25-pre6. I don't know
for kernels before 2.4.21.

Description:

If an SIOCDEVPRIVATE ioctl is sent to a tg3 device while the module is being
removed, both rmmod and the process doing the ioctl deadlock, with dev_probe_sem
and rtnl_sem held. Note that I think that there's something related to the
dev_probe_sem, because I cannot reproduce this problem when I play with
SIOCETHTOOL only, and the difference is the following :

  - SIOCETHTOOL calls dev_load(), rtnl_lock()
  - SIOCDEVPRIVATE calls dev_load(), dev_probe_lock(), rtnl_lock()

This problem happens to me everytime I restart the network drivers without
stopping keepalived first. The only solution after this is to reboot, because
the rmmod stays in D state forever.

I captured a trace with SysRQ-T that I passed through ksymoops. I have analysed
it a bit, and digged through the sources, but I reach a point where I don't
understand any more thing, because my conclusion is that the deadlock happens
between two concurrent calls to schedule(), with rtnl_sem and if dev_probe_sem
held before, but not if only rtnl_sem is held.

Thanks in advance for any help.

Willy

========== keepalived trace. This one does SIOCDEVPRIVATE =============
Proc;  keepalived

>>EIP; c03b0c20 <rtnl_sem+0/1e0>   <=====

Trace; c010751d <get_wchan+dd/220>   =====> this is __down() in fact
Trace; c0107668 <__down_failed+8/c>
Trace; c029eba9 <rtnetlink_dump_ifinfo+589/5b0>  ====> this is rtnl_lock().
Trace; c0298fcc <dev_ioctl+3f0/4a8>
Trace; c02cb44a <inet_shutdown+36e/37c>
Trace; c0291815 <sock_recvmsg+3b1/618>
Trace; c0141fe9 <kill_fasync+3f1/408>
Trace; c01086a3 <__up_wakeup+101f/13e4>

Note: rtnetlink_dump_ifinfo is at 0x660, which is 0x584 below 0xbe4,
      so the trace above clearly demonstrates that the call to
      rtnetlink_dump_ifinfo+589 is indeed rtnl_lock() called from
      dev_ioctl() :

00000000 <rtnl_lock>:
   0:   b9 00 00 00 00          mov    $0x0,%ecx
   5:   ff 0d 00 00 00 00       decl   0x0
   b:   0f 88 d3 0b 00 00       js     be4 <.text.lock.rtnetlink>
  11:   c3                      ret    
  12:   89 f6                   mov    %esi,%esi

00000660 <rtnetlink_dump_ifinfo>:

00000be4 <.text.lock.rtnetlink>:
 be4:   e8 fc ff ff ff          call   be5 <.text.lock.rtnetlink+0x1>
 be9:   e9 23 f4 ff ff          jmp    11 <rtnl_lock+0x11>

rtnl_lock() downs rtnl_sem in net/core/rtnetlink.c :

	void rtnl_lock(void)
	{
		rtnl_shlock();
		rtnl_exlock();
	}

In fact, the code at 00000be4 above calls __down_failed(), which in turn calls
__down(). The address c010751d is within __down(), just after a call to
schedule(), so schedule() never returns :

c0107510:       c7 43 04 01 00 00 00    movl   $0x1,0x4(%ebx)
c0107517:       fb                      sti    
c0107518:       e8 3f f2 00 00          call   c011675c <schedule>
c010751d:       c7 07 02 00 00 00       movl   $0x2,(%edi)
c0107523:       fa                      cli    
c0107524:       8b 43 04                mov    0x4(%ebx),%eax

All this is called from dev_ioctl() before 0xc0298fcc, which corresponds to this
code :

	default:
		if (cmd == SIOCWANDEV ||
		    (cmd >= SIOCDEVPRIVATE &&
		     cmd <= SIOCDEVPRIVATE + 15)) {
			dev_load(ifr.ifr_name);
			dev_probe_lock();
c0298fc7:		rtnl_lock();
c0298fcc:		ret = dev_ifsioc(&ifr, cmd);
			rtnl_unlock();
			dev_probe_unlock();
			if (!ret && copy_to_user(arg, &ifr, sizeof(struct ifreq)))
				return -EFAULT;
			return ret;

So clearly it waits for rtnl_lock(). Note that it has succesfully acquired
dev_probe_sem via dev_probe_lock().

BTW, strace on the other keepalived process during rmmod shows that it blocks on
SIOCETHTOOL (rtnl_lock() again) :

   ioctl(11, 0x8946, ?) (unfinished)     (0x8946 is SIOCETHTOOL)

======= keepalived trace - SIOCETHTOOL ========

Proc;  keepalived

>>EIP; c03b0c20 <rtnl_sem+0/1e0>   <=====

Trace; c010751d <get_wchan+dd/220>
Trace; c0107668 <__down_failed+8/c>
Trace; c029eba9 <rtnetlink_dump_ifinfo+589/5b0>
Trace; c0298dbb <dev_ioctl+1df/4a8>
Trace; c02cb44a <inet_shutdown+36e/37c>
Trace; c0291815 <sock_recvmsg+3b1/618>
Trace; c0141fe9 <kill_fasync+3f1/408>
Trace; c010870f <__up_wakeup+108b/13e4>
Proc;  strace

from net/core/dev.c::dev_ioctl()

	case SIOCETHTOOL:
		dev_load(ifr.ifr_name);
c0298db6:	rtnl_lock();
c0298dbb:	ret = dev_ethtool(&ifr);
		rtnl_unlock();
		if (!ret) {
			if (colon)
				*colon = ':';
			if (copy_to_user(arg, &ifr,
					 sizeof(struct ifreq)))
				ret = -EFAULT;
		}
		return ret;

So now we know exactly where all keepalived processes block :
  - one of them waits for rtnl_lock() in SIOCETHTOOL,
  - the other one waits for rtnl_lock() in SIOCDEVPRIVATE

Now, rmmod.


=========== rmmod trace ============

Proc;  rmmod

>>EIP; df87df34 <_end+1f367740/2034f86c>   <=====

Trace; c011672b <schedule_timeout+73/a4>
Trace; c0116670 <change_page_attr+184/1cc>
Trace; c029941c <unregister_netdevice+190/364>
Trace; c01d602c <unregister_netdev+10/104>
Trace; e0862d6b <_end+2034c577/2034f86c>
Trace; e0864ac0 <_end+2034e2cc/2034f86c>
Trace; c0274306 <pci_unregister_driver+3a/174>
Trace; e08630c6 <_end+2034c8d2/2034f86c>
Trace; e0864ac0 <_end+2034e2cc/2034f86c>
Trace; c011af43 <try_inc_mod_count+d7b/1508>
Trace; c011a2e7 <try_inc_mod_count+11f/1508>
Trace; c01086a3 <__up_wakeup+101f/13e4>


000020ec <unregister_netdevice>  ; unregister_netdevice+190 = 0x0000227c

    2257:       83 f8 64                cmp    $0x64,%eax
    225a:       76 10                   jbe    226c <unregister_netdevice+0x180>
    225c:       53                      push   %ebx
    225d:       6a 06                   push   $0x6
    225f:       68 20 00 00 00          push   $0x20
    2264:       e8 fc ff ff ff          call   2265 <unregister_netdevice+0x179>
    2269:       83 c4 0c                add    $0xc,%esp
    226c:       c7 07 01 00 00 00       movl   $0x1,(%edi)
    2272:       b8 19 00 00 00          mov    $0x19,%eax
    2277:       e8 fc ff ff ff          call   2278 <unregister_netdevice+0x18c>
==> 227c:       c7 07 00 00 00 00       movl   $0x0,(%edi)
    2282:       a1 00 00 00 00          mov    0x0,%eax
    2287:       29 f0                   sub    %esi,%eax
    2289:       3d e8 03 00 00          cmp    $0x3e8,%eax
    228e:       76 1b                   jbe    22ab <unregister_netdevice+0x1bf>

The corresponding portion of code is in net/core/dev.c::unregister_netdevice():

0x2257:		if ((jiffies - now) > 1*HZ) {
			/* Rebroadcast unregister notification */
			notifier_call_chain(&netdev_chain, NETDEV_UNREGISTER, dev);
		}
0x226c:		current->state = TASK_INTERRUPTIBLE;
0x2272:		schedule_timeout(HZ/4);
0x227c:		current->state = TASK_RUNNING;
		if ((jiffies - warning_time) > 10*HZ) {
			printk(KERN_EMERG "unregister_netdevice: waiting for %s to "
					"become free. Usage count = %d\n",
					dev->name, atomic_read(&dev->refcnt));
			warning_time = jiffies;
		}

Which shows that schedule_timeout(HZ/4) did not return.

000000e8 <schedule_timeout> ; schedule_timeout+73=0x15b

     150:       53                      push   %ebx
     151:       e8 fc ff ff ff          call   152 <schedule_timeout+0x6a>
     156:       e8 fc ff ff ff          call   157 <schedule_timeout+0x6f>
==>  15b:       53                      push   %ebx
     15c:       e8 fc ff ff ff          call   15d <schedule_timeout+0x75>

Which corresponds to this code in kernel/sched.c::schedule_timeout() :

	add_timer(&timer);
	schedule();
==>	del_timer_sync(&timer);

So schedule() does not return here too.

And now I have no idea where to look anymore. I don't see what can block in
schedule() when both rtnl_sem and dev_probe_sem are held...

--

