Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWCFUAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWCFUAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWCFUAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:00:12 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:43762 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932354AbWCFUAK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:00:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WO/uHwbpuGfpaqf7O4asE/OouostEpEWfZ2zORUbJ7150ehK4TY/YGMaLywfI4aw78vTMYiUY5ovurpm/OZLHaQQoo8HbIY7yZ0pcRYOpR6QtPF56R/i8E32NY0fbJ9sp6nOY5wLs8B8dFKDRvd73lbGhAyYLEYs/xBe8zL4WCQ=
Message-ID: <170fa0d20603061200y38315a62uf143258c79659381@mail.gmail.com>
Date: Mon, 6 Mar 2006 15:00:07 -0500
From: "Mike Snitzer" <snitzer@gmail.com>
To: "Maxim Kozover" <maximkoz@netvision.net.il>
Subject: Re: Re: problems with scsi_transport_fc and qla2xxx
Cc: "Andrew Vasquez" <andrew.vasquez@qlogic.com>,
       "Stefan Kaltenbrunner" <mm-mailinglist@madness.at>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <957728045.20060302193248@netvision.net.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1413265398.20060227150526@netvision.net.il>
	 <978150825.20060227210552@netvision.net.il>
	 <20060228221422.282332ef.akpm@osdl.org> <4406034B.9030105@madness.at>
	 <20060301210802.GA7288@spe2>
	 <957728045.20060302193248@netvision.net.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/06, Maxim Kozover <maximkoz@netvision.net.il> wrote:
> Hi Andrew!
> Today I tested disconnecting QLogic port.
> Adapter 4 is connected via switch to a storage and 3 LUNs are seen via
> the adapter.
> Only 1 rport is created (for FCP Target) while in Emulex case there
> were 3: (Fabric Port, Directory Server and FCP Target, FCP Initiator).
> # ls /sys/class/fc_remote_ports/
> rport-4:0-0
> # cat /sys/class/fc_remote_ports/*/roles
> FCP Target
>
> Default dev_loss_tmo is 6 (1+5) while in Emulex case the default was 35.
>
> After disconnecting the cable between the HBA and the switch
> qla2xxx 0000:03:01.0: LOOP DOWN detected (2).
>  rport-4:0-0: blocked FC remote port time out: removing target and saving binding
>
> # ls /sys/class/fc_remote_ports/
> rport-4:0-0
> # cat /sys/class/fc_remote_ports/*/roles
> unknown
>
> Relevant scsi devices are removed from /proc/scsi/scsi.
>
> After reconnecting the cable
> qla2xxx 0000:03:01.0: LIP reset occured (f7f7).
> qla2xxx 0000:03:01.0: LOOP UP detected (2 Gbps).
>
> # ls /sys/class/fc_remote_ports/
> rport-4:0-0
> # cat /sys/class/fc_remote_ports/*/roles
> FCP Target
>
> However, scsi devices don't reappear in /proc/scsi/scsi.
> When I issue rescan, the command is stuck
> echo - - - > /sys/class/scsi_host/host4/scan

Historically the qlogic driver rescan is a 2-phase process:
1) schedule the rescan, e.g.: echo scsi-qlascan > /proc/scsi/qla2xxx/4
2) rescan, e.g.: echo - - - > /sys/class/scsi_host/host4/scan

BUT, I've just used scsi-qlascan to discover _new_ devices... not
existing devices that experienced FC connection loss.  I assume the
qla driver _should_ just bring those lost devices back?  But does the
historic 2-phase rescan for new devices speak to why the qlogic driver
doesn't automagically bring the old devices back?  Or has the latest
qlogic driver in mainline advanced past this 2-phase requirement in
general?

regards,
Mike

Mike
