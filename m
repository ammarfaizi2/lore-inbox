Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbUDPQ5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUDPQ51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:57:27 -0400
Received: from smtp.rol.ru ([194.67.21.9]:49467 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S263425AbUDPQ5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:57:08 -0400
From: Konstantin Sobolev <kos@supportwizard.com>
Reply-To: kos@supportwizard.com
Organization: SupportWizard
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: poor sata performance on 2.6
Date: Fri, 16 Apr 2004 20:59:44 +0400
User-Agent: KMail/1.6.1
Cc: Jeff Garzik <jgarzik@pobox.com>, Justin Cormack <justin@street-vision.com>,
       Ryan Geoffrey Bourgeois <rgb005@latech.edu>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <200404150236.05894.kos@supportwizard.com> <407F315E.2000809@pobox.com> <200404161748.38958.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404161748.38958.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404162059.44465.kos@supportwizard.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 April 2004 18:48, Denis Vlasenko wrote:
> > When you mount a filesystem, it changes the default block size (512 or
> > 1024) to the filesystem block size, normally 4096.  This would certainly
> > increase the throughput.
>
> Yes, this works.
>
> But if one uses unpartitioned disk, why does (s)he need to
> do some blocksize tricks before hdparm starts to measure good performance?
> I think that in this case block layer can coalesce small read requests
> into large ones regardless of block size.
>
> Konstantin, does dd give you the same behaviour as hdparm?

Sorry, I already partitioned it and put lots of data there.
But situation is reproducible by removing all /dev/sda entries from fstab and rebooting. Here are results of my experiments with dd:

kos root # bash -c "sleep 10 && killall -3 dd &" && LANG=C time dd if=/dev/sda of=/dev/null ibs=512 obs=512
537152+0 records in
537152+0 records out
Command terminated by signal 3
0.23user 3.73system 0:10.07elapsed 39%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+121minor)pagefaults 0swaps

kos root # hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:   84 MB in  3.07 seconds =  27.37 MB/sec
kos root # bash -c "sleep 10 && killall -3 dd &" && LANG=C time dd if=/dev/sda of=/dev/null ibs=4096 obs=4096
71691+0 records in
71691+0 records out
Command terminated by signal 3
0.07user 3.83system 0:10.08elapsed 38%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+122minor)pagefaults 0swaps

kos root # mount /dev/sda2 /wd
kos root # hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:   84 MB in  3.07 seconds =  27.38 MB/sec

kos root # hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  206 MB in  3.02 seconds =  68.13 MB/sec

kos root # bash -c "sleep 10 && killall -3 dd &" && LANG=C time dd if=/dev/sda of=/dev/null ibs=512 obs=512
1402384+0 records in
1402384+0 records out
Command terminated by signal 3
0.54user 2.57system 0:10.02elapsed 31%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+121minor)pagefaults 0swaps

kos root # bash -c "sleep 10 && killall -3 dd &" && LANG=C time dd if=/dev/sda of=/dev/null ibs=4096 obs=4096
329705+0 records in
329705+0 records out
Command terminated by signal 3
0.32user 2.43system 0:10.13elapsed 27%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+122minor)pagefaults 0swaps

It looks like dd behaves similarly to hdparm

-- 
/KoS
* yas eh d'tahW.	ÀÀmih raeh uoy diD				      
