Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWFAW2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWFAW2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWFAW2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:28:45 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:24836 "EHLO
	mms1.broadcom.com") by vger.kernel.org with ESMTP id S1750814AbWFAW2n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:28:43 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [openib-general] Re: [PATCH 1/2] iWARP Connection Manager.
Date: Thu, 1 Jun 2006 15:28:24 -0700
Message-ID: <54AD0F12E08D1541B826BE97C98F99F150D3E6@NT-SJCA-0751.brcm.ad.broadcom.com>
Thread-Topic: [openib-general] Re: [PATCH 1/2] iWARP Connection Manager.
Thread-Index: AcaFyVcoQ4m2/vFMThmXi2GP42LuUwAAQL6Q
From: "Caitlin Bestler" <caitlinb@broadcom.com>
To: "Tom Tucker" <tom@opengridcomputing.com>,
       "Sean Hefty" <mshefty@ichips.intel.com>
cc: "Steve Wise" <swise@opengridcomputing.com>, netdev@vger.kernel.org,
       rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006060110; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230392E34343746363735422E303033462D412D;
 ENG=IBF; TS=20060601222830; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006060110_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6861B5800HW24787619-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 
>> There's a difference between trying to handle the user calling
>> disconnect/destroy at the same time a call to accept/connect is
>> active, versus the user calling disconnect/destroy after
>> accept/connect have returned.  In the latter case, I think you're
>> fine.  In the first case, this is allowing a user to call
> destroy at the same time that they're calling accept/connect.
>> Additionally, there's no guarantee that the F_CONNECT_WAIT flag has
>> been set by accept/connect by the time disconnect/destroy tests it.
> 
> The problem is that we can't synchronously cancel an
> outstanding connect request. Once we've asked the adapter to
> connect, we can't tell him to stop, we have to wait for it to
> fail. During the time period between when we ask to connect
> and the adapter says yeah-or-nay, the user hits ctrl-C. This
> is the case where disconnect and/or destroy gets called and
> we have to block it waiting for the outstanding connect
> request to complete.
> 
> One alternative to this approach is to do the kfree of the
> cm_id in the deref logic. This was the original design and
> leaves the object around to handle the completion of the
> connect and still allows the app to clean up and go away
> without all this waitin' around. When the adapter finally
> finishes and releases it's reference, the object is kfree'd.
> 
> Hope this helps.
> 
Why couldn't you synchronously put the cm_id in a state of
"pending delete" and do the actual delete when the RNIC
provides a response to the request? There could even be
an optional method to see if the device is capable of
cancelling the request. I know it can't yank a SYN back
from the wire, but it could refrain from retransmitting.

