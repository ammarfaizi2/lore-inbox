Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312294AbSDPKaA>; Tue, 16 Apr 2002 06:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312316AbSDPK1z>; Tue, 16 Apr 2002 06:27:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55825 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312294AbSDPK1s>;
	Tue, 16 Apr 2002 06:27:48 -0400
Date: Tue, 16 Apr 2002 12:25:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Aaron Tiensivu <mojomofo@mojomofo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020416102510.GI17043@suse.de>
In-Reply-To: <20020415125606.GR12608@suse.de> <02db01c1e498$7180c170$58dc703f@bnscorp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15 2002, Aaron Tiensivu wrote:
> Simple question but hopefully it has a simple answer.. is there a command
> you can issue or flag you can look for from the output of hdparm to tell if
> your hard drive is capable of TCQ before installing the patch? I have a few
> IBM drives that I'm sure have TCQ abilities but I don't trust them as far as
> I can throw them (being Hungarian and cursed) but I'd like to give TCQ a
> whirl on my WD 120GB drives that should work OK, if they support TCQ..
> 
> Sorry if it's already been asked.. :)

Mark Hahn wrote this little script to detect support for TCQ, modified
by me to not use the hdX symlinks.

-- 
Jens Axboe


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=tcq_support

#!/usr/bin/perl

# bit 1 (TCQ) and 14 (word is valid) must be set to indicate tcq support
$mask = (1 << 1) | (1 << 14);

# bit 15 must be cleared too
$bits = $mask | (1 << 15);

# mail me the results!
$addr = "linux-tcq\@kernel.dk";

foreach $i (</proc/ide/ide*>) {
	foreach $d (<$i/hd*>) {
		@words = split(/\s/,`cat $d/identify`);
		$w83 = hex($words[83]);
		if (!(($w83 & $bits) ^ $mask)) {
			$model = `cat $d/model`;
			push(@goodies, $model);
			chomp($model);
			print "$d ($model) supports TCQ\n";
		}
	}
}

if ($addr && $#goodies) {
	open(M, "| mail -s TCQ-report $addr");
	print M @goodies;
	close(M);
}

--4bRzO86E/ozDv8r1--
