Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbTBNQRp>; Fri, 14 Feb 2003 11:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268451AbTBNQRp>; Fri, 14 Feb 2003 11:17:45 -0500
Received: from gate.in-addr.de ([212.8.193.158]:64263 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S267200AbTBNQRn>;
	Fri, 14 Feb 2003 11:17:43 -0500
Date: Fri, 14 Feb 2003 17:27:22 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: steve cameron <steve.cameron@hp.com>, linux-kernel@vger.kernel.org
Subject: Re: Accessing the same disk via multiple channels
Message-ID: <20030214162722.GB11209@marowsky-bree.de>
References: <20030214032012.GA5481@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030214032012.GA5481@zuul.cca.cpqcorp.net>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-02-14T09:20:12,
   steve cameron <steve.cameron@hp.com> said:

> Yay!  We noticed that if a controller fails in such a way that
> no interrupts are generated then md driver doesn't notice anything is 
> wrong.  Commands don't fail, but don't complete either. 

Uhhhhh. They should timeout though and then be counted as errors; hard to
catch this differently.

You are saying it doesn't work?

> (Better than putting a timeout on every command.)  Also, md multipath 
> doesn't notice if the backup path has failed, to warn the user that 
> redundancy is no longer in effect.  (Though if you set up things so i/o 
> is going down both paths, not such a big deal, as md will notice.
> Probably you know all this already.

Yes. We intentionally don't do active _monitoring_ on non-active paths, same
as we don't do reprobing of failed paths to see whether they are alive again.

(The LVM m-p patch does periodically send down live requests to failed paths
to check this; I consider this intentional data corruption, but I'm
paranoid.)

This is something which can easily be implemented safely in user-space
though; the md approach still exposes the lower level devices and you can
check them periodically if you care, and be it with a 

	while sleep 1 ; do
		if ! dd if=/dev/sdaX of=/dev/null ; then
			mdadm /dev/md0 --fail /dev/sdaX
			logger -p kern.alert "Path /dev/sdaX failed!"
		fi
	done

;-) Obviously, not something we need to run in kernel space.


> Well, the cciss driver is not a SCSI driver (except for purpsoes of 
> tape drives & tape changers) and HP/Compaq has sold more than one 
> million of those controllers (does popularity mean they aren't 
> "weird"? :-), and we have mulitpath capable storage boxes they 
> can connect to.

Indeed. Yes, we'll need to figure out how to do this for 2.5/2.6; maybe
porting forward the md m-p patch to 2.5 is indeed the best choice. It should
be way easier, as md has been greatly cleaned up...

However, past discussions on LKML regarding "How to do m-p cleanly in 2.5"
have never reached a conclusion ;-) We'll see. The good thing about the SCSI
m-p is that it can also handle multipathed tape drives...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
