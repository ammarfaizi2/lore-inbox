Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbTC0WSN>; Thu, 27 Mar 2003 17:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbTC0WSM>; Thu, 27 Mar 2003 17:18:12 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:52654 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S261442AbTC0WSL>; Thu, 27 Mar 2003 17:18:11 -0500
Message-Id: <200303272228.h2RMSSGi009141@locutus.cmf.nrl.navy.mil>
To: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ATM] second pass at fixing atm spinlock 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 27 Mar 2003 17:28:28 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, here is a further attempt at fixing the smp problems in the linux-atm
stack.  things have been moved around in net/atm:

. atm sk's are reference counted.  this makes the vcc_release (renamed
  from atm_release_vcc for consistency) and svc_release easier to write
  since you dont need to explicity free the sk
. vcc's are stored as a list of sockets, like other protocols
. atm drivers should use vcc_hold/vcc_put to modify reference counts.  the
  driver should read_lock(vcc_sklist_lock) before doing a vcc_hold() if
  they are in their 'bottom half'.  i converted eni, idt77252 (untested --
  no hardware), fore200e (untest -- lazy) and nicstar.  i also included the
  he driver.  the eni driver is special, since the bottom half is a tasklet
  you can simply stop the bottom half and be sure the bottom half
  isnt holding a reference.  the he just grabs the vcc_sklist_lock and 
  processes all the vcc's needing serviced.  a vcc cant disappear while 
  the lock is held (since the vcc_release needs to do a write_lock to unhash
  the socket/vcc before dropping the refcnt to 0).
. the nodev list has been removed and bind_vcc/unlink have been changed to
  just insert/remove vcc list operations.  this makes things a bit clearer.
. driver's check_ci() routine have been removed in favor of the one in
  atm_misc.c.  very few were actually any faster, and this functionality is
  rarely used.
. there is a new function, vcc_lookup(), used mostly by the fore200e and he
  driver.  vcc's returned by this function will need a vcc_put() or the
  ref count will be wrong.  in the future, most drivers should probably 
  use this function to find the vcc for their newly arrived data.  there
  possibly could be a routine atmif_rx(atmdev, skb, vpi, vci) which 
  just does the right thing.  ideally, atm would use netif_rx() but one
  would need to dummy up a ethernet header on each of the pdu's.  comments
  on that idea?
. all the stuff from the previous version: atmdev ref counting, atm and 
  clip can now build as modules.

ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_5_64_atm_dev_lock.patch

[i will try to get a 2.5.65 version available this weekend]
