Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262426AbTDAMFd>; Tue, 1 Apr 2003 07:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbTDAMFd>; Tue, 1 Apr 2003 07:05:33 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:11935 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S262426AbTDAMFb>;
	Tue, 1 Apr 2003 07:05:31 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Tue, 1 Apr 2003 14:16:53 +0200
To: Alan Cox <alan@redhat.com>, Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDE SiI680] throughput drop to 1/4
Message-ID: <20030401121653.GA1313@pc11.op.pod.cz>
Mail-Followup-To: Alan Cox <alan@redhat.com>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20030324072910.GA16596@pc11.op.pod.cz> <Pine.LNX.4.10.10303240943070.8000-100000@master.linux-ide.org> <20030324072910.GA16596@pc11.op.pod.cz> <200303241213.h2OCD6u21467@devserv.devel.redhat.com> <20030325070605.GA26860@pc11.op.pod.cz> <20030326065650.GA10282@pc11.op.pod.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326065650.GA10282@pc11.op.pod.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 07:56:50AM +0100, Vitezslav Samel wrote:
> On Tue, Mar 25, 2003 at 08:06:05AM +0100, Vitezslav Samel wrote:
> > On Mon, Mar 24, 2003 at 07:13:06AM -0500, Alan Cox wrote:
> > > >   Recently I tried to figure out in 2.5.65, why throughput on my disk which
> > > > hangs on Silicon Image 680 dropped to 1/4 compared to 2.4.21-pre5, but didn't
> > > > found anything useful. Are there any known issues with this driver?
> > > 
> > > The same code in both cases. Its quite likely the problem is higher up in
> > > the block or filesystem layer. It might also be a general IDE layer bug
> > > 
> > > What does performance look like on your other disk between
> > > 2.4.21pre/2.5.65 ?
> > 
> >   Will test it as I come back home (it's on my home machine). But I think this
> > performance drop is only on the SiI680 interface.
> 
>   Tested today: on the other disk on integrated interface (piix) is throughput
> exactly the same on both kernels.

  I put my eyes on /etc/rc.d/* and found hdparm doing some magic; then I tried
to fiddle with its params and came to this: the problem lied in fs readahead
(hdparm -a xxx). Tried various numbers:

 fs readahead	throughput in 2.5.66	throughput in 2.4.21-pre6
-----------------------------------------------------------------
  0		11.94 MB/sec		40.00 MB/sec
  8		12.01 MB/sec            38.79 MB/sec
 16		12.04 MB/sec            40.25 MB/sec
 24		15.22 MB/sec            39.51 MB/sec
 32		15.17 MB/sec            40.00 MB/sec
 40		15.20 MB/sec            39.02 MB/sec
 48		15.26 MB/sec            40.00 MB/sec
 56		17.60 MB/sec            40.25 MB/sec
 64		16.03 MB/sec            40.00 MB/sec
 64		15.95 MB/sec            40.25 MB/sec
 72		17.32 MB/sec            40.00 MB/sec
 80		18.34 MB/sec            40.25 MB/sec
 88		18.72 MB/sec            40.25 MB/sec
 96		16.04 MB/sec            39.26 MB/sec
104		16.68 MB/sec            40.25 MB/sec
112		18.25 MB/sec            39.02 MB/sec
120		18.42 MB/sec            40.00 MB/sec
128		19.17 MB/sec            39.26 MB/sec
136		26.67 MB/sec            40.00 MB/sec
144		39.31 MB/sec            39.51 MB/sec
152		39.58 MB/sec            39.75 MB/sec
160		39.68 MB/sec            40.25 MB/sec
168		39.98 MB/sec            40.25 MB/sec
176		39.85 MB/sec            40.51 MB/sec
184		40.18 MB/sec            40.00 MB/sec

  So I disabled setting fs readahead (the default values are O.K.). Seems
like setting fs readahead doesn't make any change on 2.4 kernels.

	Cheers,
		Vita
