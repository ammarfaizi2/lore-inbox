Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbUCQMGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 07:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUCQMGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 07:06:32 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:61849 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261402AbUCQMGY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 07:06:24 -0500
Subject: Re: [PATCH] s390 (8/10): zfcp fixes.
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF876C2271.59086B92-ONC1256E5A.00409933-C1256E5A.00427853@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 17 Mar 2004 13:06:01 +0100
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 17/03/2004 13:06:03
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi Greg,

> This is not ok.  If you have to do something like this, I really suggest
> that you not allow the "sub modules" be able to unload before the upper
> module can.  In fact, why would you want to do such a thing?
How do sub modules help with the release function problem? The unit/port
objects get unregistered in zfcp_unit_dequeue. This happens e.g. when
a zfcp adapter gets removed because of a detach. After the last zfcp
adapter got removed the module is in principle ready to be removed.
Now there are two cases. 1) The module count of the zfcp module (or one
of the non-existent sub-modules) is NOT increase because of the outstanding
call to the release function. It obvious that the release function can't
be part of the zfcp module(s) in this case. 2) The module count of the
zfcp module(s) is elevated because of the outstanding call to release.
Who does the module_put in this case? The release function only can do it
if it is not part of ANY of the modules. If it is part of a zfcp module
the cpu doing the module_put might not be able to get out of the release
function fast enough before another cpu has removed the module(s)
(including the sub-modules).
Did I miss something ?

> I still really strongly object to this patch.  If it's a scsi problem,
> fix it there, but odds are it's your driver's problem as no other scsi
> driver needs this.
If we can move the port/unit objects to the scsi mid layer that would
"solve" the problem for the zfcp module. But the problem itself doesn't
go away. It's just moved one step up the ladder.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


