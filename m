Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132072AbRDJUCN>; Tue, 10 Apr 2001 16:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132056AbRDJUCF>; Tue, 10 Apr 2001 16:02:05 -0400
Received: from tux.mkp.net ([130.225.60.11]:16390 "EHLO tux.mkp.net")
	by vger.kernel.org with ESMTP id <S132057AbRDJUBx>;
	Tue, 10 Apr 2001 16:01:53 -0400
To: linux-lvm@sistina.com
Cc: lvm-devel@sistina.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [linux-lvm] *** ANNOUNCEMENT *** LVM 0.9.1 Beta 7 available at www.sistina.com
In-Reply-To: <20010410182550.A20569@sistina.com>
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
Date: 10 Apr 2001 16:01:04 -0400
In-Reply-To: <20010410182550.A20569@sistina.com>
Message-ID: <yq1puekr0cf.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.2 (Urania)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Heinz" == Heinz J Mauelshagen <Mauelshagen@sistina.com> writes:

Heinz> a tarball of the Linux Logical Volume Manager 0.9.1 Beta 7 is
Heinz> available now at

The following code is baaaad, m'kay...

[...]

	down(&_pe_lock);
	if((pe_lock_req.lock == LOCK_PE) &&
	   (rdev_map == pe_lock_req.data.pv_dev) &&
	   (rsector_map >= pe_lock_req.data.pv_offset) &&
	   (rsector_map < (pe_lock_req.data.pv_offset + vg_this->pe_size)) &&
	   ((rw == WRITE) || (rw == WRITEA))) {
		/* defer this bh until the PE has moved */
		if(((int) bh) & 0x3) {
			printk(KERN_ERR 
			       "%s -- bh uses low 2 bits of pointer\n",
			       lvm_name);
			up(&_pe_lock);
			goto bad;
		}

		bh->b_reqnext = _pe_requests;
		_pe_requests = (struct buffer_head *) ((int) bh | rw);
		up(&_pe_lock);
		up(&lv->lv_snapshot_sem);
		return 0;
	}
	up(&_pe_lock);

[...]

		/* handle all deferred io for this PE */
		while(q) {
			struct buffer_head *d_bh = 
			       (struct buffer_head *) (q & ~0x3);
			int rw = q & 0x3;
			q = (uint) d_bh->b_reqnext;
 
			/* resubmit this buffer head */
			d_bh->b_reqnext = 0;
			generic_make_request(rw, d_bh);
		}


Not only is this an evil hack from hell, I don't understand why you go
through such a huge effort of storing rw in the pointer.  Afaict, the
only valid value is WRITE.  And WRITEA is #defined to WRITE in lvm.c.

-- 
Martin K. Petersen, Principal Linux Consultant, Linuxcare, Inc.
mkp@linuxcare.com, http://www.linuxcare.com/
SGI XFS for Linux Developer, http://oss.sgi.com/projects/xfs/
