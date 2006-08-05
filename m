Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWHEX2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWHEX2b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 19:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWHEX2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 19:28:30 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:53144 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1751409AbWHEX2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 19:28:30 -0400
Date: Sat, 5 Aug 2006 16:28:29 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: David Lang <dlang@digitalinsight.com>
cc: Mark Fasheh <mark.fasheh@oracle.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Valerie Henson <val_henson@linux.intel.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
In-Reply-To: <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz>
Message-ID: <Pine.LNX.4.64.0608051612330.20926@twinlark.arctic.org>
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> 
 <1154797123.12108.6.camel@kleikamp.austin.ibm.com> 
 <1154797475.3054.79.camel@laptopd505.fenrus.org>  <20060805183609.GA7564@tuatara.stupidest.org>
 <20060805222247.GQ29686@ca-server1.us.oracle.com>
 <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2006, David Lang wrote:

> On Sat, 5 Aug 2006, Mark Fasheh wrote:
> 
> > On Sat, Aug 05, 2006 at 11:36:09AM -0700, Chris Wedgwood wrote:
> > > should it be atime-dirty or non-critical-dirty? (ie. make it more
> > > generic to cover cases where we might have other non-critical fields
> > > to flush if we can but can tolerate loss if we dont)
> > So, just to be sure - we're fine with atime being lost due to crashes,
> > errors, etc?
> 
> at least as a optional mode of operation yes.
> 
> I'm sure someone will want/need the existing 'update atime immediatly', and
> there are people who don't care about atime at all (and use noatime), but
> there is a large middle ground between them where atime is helpful, but
> doesn't need the real-time update or crash protection.

i can't understand when atime is *ever* reliable... root doing backups 
with something like rsync will cause atimes to change.  (and it can't 
save/restore the atime without race conditions.)

you can work around mutt's silly dependancy on atime by configuring it 
with --enable-buffy-size.  so far mutt is the only program i've discovered 
which cares about atime.

also -- i wasn't aware that xfs tried to do a better job with atime
updates... i'm not sure it's really that effective.  i've got a
busy shell/mail/web server, and here's a typical 60s sample with
noatime,nodiratime on xfs:

Device:    rrqm/s wrqm/s   r/s   w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda          0.00   0.77 13.72 25.94   418.34   328.72    18.84     2.21   55.75   3.63  14.40

and a typical 60s sample with atime,diratime:

sda          0.07   0.58 15.82 35.87   472.13   412.52    17.12     0.70   13.56   3.54  18.30

that's been my experience in general... an extra 15 to 20% iops required 
to maintain atime... just for mutt...  no thanks :)

(btw there's nvram underneath sda, so the await change isn't too 
surprising.)

-dean

p.s. lazyatime sounds like a nice hack to make mutt work too.
