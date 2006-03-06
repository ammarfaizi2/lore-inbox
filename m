Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWCFV2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWCFV2i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWCFV2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:28:38 -0500
Received: from pat.qlogic.com ([198.70.193.2]:7606 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S932338AbWCFV2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:28:37 -0500
Date: Mon, 6 Mar 2006 13:28:35 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Maxim Kozover <maximkoz@netvision.net.il>
Cc: Mike Snitzer <snitzer@gmail.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: problems with scsi_transport_fc and qla2xxx
Message-ID: <20060306212835.GO6278@andrew-vasquezs-powerbook-g4-15.local>
References: <1413265398.20060227150526@netvision.net.il> <978150825.20060227210552@netvision.net.il> <20060228221422.282332ef.akpm@osdl.org> <4406034B.9030105@madness.at> <20060301210802.GA7288@spe2> <957728045.20060302193248@netvision.net.il> <170fa0d20603061200y38315a62uf143258c79659381@mail.gmail.com> <1119462161.20060306230951@netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119462161.20060306230951@netvision.net.il>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 06 Mar 2006 21:28:37.0240 (UTC) FILETIME=[EE03CF80:01C64164]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2006, Maxim Kozover wrote:

> Unfortunately I don't have the directory /proc/scsi/qla2xxx.

The two stage discovery process has not been needed since FC transport
integration.  Instead, the driver simply makes up-calls to signal
rport visiblity (add on PLOGI/PRLI; delete on LOGO/cable-pull/etc).

> However the target sees PRLI from the host again after reconnecting
> the cable between the initiator and the switch.
> Does it mean the rediscovering new devices on initiator side is
> already done?
> 

Yes, after plugging the cable back in, the driver rediscovers ports:

	Mar  3 01:07:22 multipath kernel: scsi(4): RSNN_NN exiting normally.
	Mar  3 01:07:22 multipath kernel: scsi(4): GID_PT entry - nn 200000e08b079a69 pn 210000e08b079a69 portid=010700.
	Mar  3 01:07:22 multipath kernel: scsi(4): GID_PT entry - nn 2000001738279c00 pn 1000001738279c11 portid=010200.
	Mar  3 01:07:22 multipath kernel: scsi(4): device wrap (010200)

Initiates PLOGI/PRLI: 

	Mar  3 01:07:22 multipath kernel: scsi(4): Trying Fabric Login w/loop id 0x0081 for port 010200.

And upcall via fc_remote_port_add() is done.

	Mar  3 01:07:22 multipath kernel: scsi(4): LOOP READY
	Mar  3 01:07:22 multipath kernel: scsi(4): qla2x00_loop_resync - end

Firmware then notifies software that the port has logged out:

	Mar  3 01:07:22 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0081/0007/7ee5.
	Mar  3 01:07:22 multipath kernel: scsi(4:0:0): status_entry: Port Down pid=43, compl status=0x29, port state=0x4

A CDB also returns with a completion status of PORT_LOGGED_OUT.  From
the driver's DPC routine (process-context), the upcall to
fc_remote_port_delete() is issued:

Driver attempts a relogin:

	Mar  3 01:07:22 multipath kernel: scsi(4): Port login retry: 1000001738279c11, id = 0x0081 retry cnt=8
	Mar  3 01:07:23 multipath kernel: scsi(4): fcport-0 - port retry count: 0 remaining
	Mar  3 01:07:23 multipath kernel: scsi(4): qla2x00_port_login()
	Mar  3 01:07:23 multipath kernel: scsi(4): Trying Fabric Login w/loop id 0x0081 for port 010200.

Relogin complete

	Mar  3 01:07:23 multipath kernel: scsi(4): port login OK: logged in ID 0x81

Upcall to fc_remote_port_add() done.

	Mar  3 01:07:23 multipath kernel: scsi(4): qla2x00_port_login - end
	Mar  3 01:07:23 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0000/0006/0001.
	Mar  3 01:07:23 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0000/0007/0001.
	Mar  3 01:07:23 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0000/0004/0001.
	Mar  3 01:07:24 multipath kernel: scsi(4): Asynchronous PORT UPDATE ignored 0081/0006/0001.

I also noticed that scsi_transport_fc.c::fc_user_scan() is not called
with the host_lock held... hmm..  could you try out the patch I sent
earlier and provide the results.

Also, could you send the "echo t > /proc/..." output after the cable
has been reinserted, but, before the 'echo "- - -" > /sys/class' scan
is initiated.

thanks,
av
