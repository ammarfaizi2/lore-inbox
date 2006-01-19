Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbWASAnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWASAnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWASAnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 19:43:45 -0500
Received: from mx.pathscale.com ([64.160.42.68]:58247 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161111AbWASAno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 19:43:44 -0500
Subject: RFC: ipath ioctls and their replacements
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Cc: openib-general@openib.org
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 18 Jan 2006 16:43:31 -0800
Message-Id: <1137631411.4757.218.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I posted the last round of ipath driver code for review, people
objected to the number of ioctls we had.  I'd like to get feedback on
what would be acceptable replacements.

We have four kinds of ioctl right now:

      * Interfacing with userspace
      * Infiniband subnet management
      * Flash/EEPROM management
      * Diagnostics

There are currently 36 ioctls in total.  I think that I can reduce this
number dramatically, but we're having some contentious internal debate
about whether and how some of the ioctls should be replaced.  I'd like
to see what's most likely to get accepted.  Obviously, we'd prefer the
number to be zero, but I don't think we can do that without submitting a
driver that isn't very useful.

Unless I indicate otherwise, I cannot think of clean replacements for
the ioctls listed below, and would appreciate suggestions.

For user access:

        Opening the /dev/ipath special file assigns an appropriate free
        unit (chip) and port (context on a chip) to a user process.
        Think of it as similar to /dev/ptmx for ttys, except there isn't
        a devpts-like filesystem behind it.  Once a process has
        opened /dev/ipath, it needs to find out which unit and port it
        has opened, so that it can access other attributes in /sys.  To
        do this, we provide a GETPORT ioctl.
        
        USERINIT and BASEINFO work with mmap to set up direct access to
        the hardware for user processes.  We intend to turn these into a
        single ioctl, USERINIT.  This copies a substantial amount of
        information to and from userspace.
        
        RCVCTRL enables/disables receipt of packets.
        
        SET_PKEY sets a partition key, essentially telling hardware
        which packets are interesting to userspace.
        
        UPDM_TID and FREE_TID are used for RDMA context management.
        
        WAIT waits for incoming packets, and can clearly be replaced by
        file_ops->poll.
        
        GETCOUNTERS, GETUNITCOUNTERS and GETSTATS can all be replaced by
        files in sysfs.

For subnet management:

        GETLID, SET_LID, SET_MTU, SET_GUID, SET_MLID, GET_MLID,
        GET_DEVSTATUS, GET_PORTINFO and GET_NODEINFO can all be replaced
        by files in sysfs.
        
        SET_LINKSTATE changes the link state.
        
        SEND_SMA_PKT and RCV_SMA_PKT send and receive subnet management
        packets.  I *think* they could be replaced by read and write
        methods on a new special file, although the semantics aren't a
        super-clean match.
        
For EEPROM/flash management:

        READ_EEPROM reads the flash.  WRITE_EEPROM writes it.  I don't
        see a standard way of doing this in the kernel; many drivers
        provide their own private ioctls, some on dedicated special
        files.  I think that using read and write instead would be okay
        (with a small qualm about semantics), but this idea makes an
        influential coworker barf violently.  I can't see how we could
        use the ethtool flash interface: the low-level driver doesn't
        look like a regular net device, and we support partial updates
        of the flash.
        
For diagnostics:

        DIAGENTER and DIAGLEAVE put the driver into and out of diag
        mode.  These could be replaced by open/close of a special file.
        
        DIAGREAD and DIAGWRITE perform direct accesses to the device's
        PCI memory space.  I think these could be replaced by read and
        write, but they are again subject to the make-coworker-barf
        problem.
        
        HTREAD and HTREAD perform direct accesses to the device's PCI
        config space.  Same disagreement problem as DIAGREAD and
        DIAGWRITE.
        
        SEND_DIAG_PKT can be replaced with whatever sends and receives
        subnet management packets, as above.
        
        DIAG_RD_I2C is synonymous with READ_EEPROM, and will go away.

Depending on how you look at it, we can slim our list of ioctls down to
somewhere between 6 and 10.  This isn't zero, but it's not 36, either.
What do people think?

	<b

