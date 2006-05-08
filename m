Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWEHRR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWEHRR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEHRRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:17:55 -0400
Received: from mail.gmx.de ([213.165.64.20]:53969 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932487AbWEHRRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:17:55 -0400
X-Authenticated: #14349625
Subject: Re: High load average on disk I/O on 2.6.17-rc3
From: Mike Galbraith <efault@gmx.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060508154217.GH1875@harddisk-recovery.com>
References: <200605051010.19725.jasons@pioneer-pra.com>
	 <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org>
	 <1147100149.2888.37.camel@laptopd505.fenrus.org>
	 <20060508152255.GF1875@harddisk-recovery.com>
	 <1147102290.2888.41.camel@laptopd505.fenrus.org>
	 <20060508154217.GH1875@harddisk-recovery.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 19:18:03 +0200
Message-Id: <1147108683.8026.52.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 17:42 +0200, Erik Mouw wrote:
> On Mon, May 08, 2006 at 05:31:29PM +0200, Arjan van de Ven wrote:
> > On Mon, 2006-05-08 at 17:22 +0200, Erik Mouw wrote:
> > > ... except that any kernel < 2.6 didn't account tasks waiting for disk
> > > IO.
> > 
> > they did. It was "D" state, which counted into load average.
> 
> They did not or at least to a much lesser extent. That's the reason why
> ZenIV.linux.org.uk had a mail DoS during the last FC release and why we
> see load average questions on lkml.

I distinctly recall it counting, but since I don't have a 2.4 tree
handy, I'll refrain from saying "did _too_" ;-)

> I've seen it on our servers as well: when using 2.4 and doing 50 MB/s
> to disk (through NFS), the load just was slightly above 0. When we
> switched the servers to 2.6 it went to ~16 for the same disk usage.

The main difference I see is...

8129 root      15   0  3500  512  432 D 56.0  0.0   0:33.72 bonnie
 1393 root      10  -5     0    0    0 D  0.4  0.0   0:00.26 kjournald
 8135 root      15   0     0    0    0 D  0.0  0.0   0:00.01 pdflush
  573 root      15   0     0    0    0 D  0.0  0.0   0:00.00 pdflush
  574 root      15   0     0    0    0 D  0.0  0.0   0:00.04 pdflush
 8131 root      15   0     0    0    0 D  0.0  0.0   0:00.01 pdflush
 8141 root      15   0     0    0    0 D  0.0  0.0   0:00.00 pdflush

With 2.4, there was only one flush thread.  Same load, different
loadavg... in this particular case of one user task running.  IIRC, if
you had a bunch of things running and running you low on memory, you
could end up with a slew of 'D' state tasks in 2.4 as well, because
allocating tasks had to help free memory by flushing buffers and pushing
swap.  Six to one, half a dozen to the other.

	-Mike

