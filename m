Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVH2IFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVH2IFZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 04:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVH2IFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 04:05:25 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:5860 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751205AbVH2IFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 04:05:24 -0400
To: James Bottomley <jejb@steeleye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux SCSI <linux-scsi@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] zfcp: add rports to enable scsi_add_device to work	again
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
From: Andreas Herrmann <AHERRMAN@de.ibm.com>
X-MIMETrack: S/MIME Sign by Notes Client on Andreas Herrmann/Germany/IBM(Release 5.0.11
  |July 24, 2002) at 29.08.2005 10:03:09,
	Serialize by Notes Client on Andreas Herrmann/Germany/IBM(Release 5.0.11  |July
 24, 2002) at 29.08.2005 10:03:09,
	Serialize complete at 29.08.2005 10:03:09,
	S/MIME Sign failed at 29.08.2005 10:03:09: The cryptographic key was not
 found,
	Serialize by Router on D12ML065/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 29/08/2005 10:05:22,
	Serialize complete at 29/08/2005 10:05:22
Message-ID: <OF1521E79F.4A773662-ONC125706C.002BFB9E-C125706C.002C3EDC@de.ibm.com>
Date: Mon, 29 Aug 2005 10:05:20 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.08.2005 19:38 James Bottomley <jejb@steeleye.com> wrote:
 
  > > this patch fixes a severe problem with 2.6.13-rc7.
  > > 
  > > Due to recent SCSI changes it is not possible to add any
  > > LUNs to the zfcp device driver anymore. With registration
  > > of remote ports this is fixed.
  > > 
  > > Please integrate the patch in the 2.6.13 kernel or if it
  > > is already too late for this release then please integrate it
  > > in 2.6.13.1
  > > 
  > > Thanks a lot.

  > Well, OK, but your usage isn't quite optimal.  The fibre channel
  > transport class retains a list of ports per host, so your maintenance 
of
  > an identical list in zfcp_adapter duplicates this.

I know what you mean. It would be better to store all "private" zfcp
data at dd_data in fc_rport.  Unfortunately it won't fit to zfcp's
current behaviour.  The rport depends on a specific host_id. Even the
name of the rport in sys/class/fc_remote_port inherits this id. This
means if the host is deregistered and registered again the old rport
structure is useless because new host_ids are assigned. Or do I miss
something here?

The zfcp_port structure is thought to be persistent if once configured
by the user, i.e. even if the host is deregistered and registered
again the port structure is kept.

I am not sure at the moment how this can be solved with the current
fc_transport. I think it would have been better to use the WWPN of an
rport as the name in sys/class/fc_remote_port. This would be a start
to keep rport structures independent of the host_id. (Why should the
transport depend on OS assigned ids anyway? The transport has already
unique identifiers like WWPNs.)

  > However, we can put this in for now and worry about removing all of 
the
  > fc transport class duplication from zfcp later.

  > James

In any case attributes provided by an rport should be removed from the
zfcp_port structure. This is what I will do next.


Regards,

Andreas
