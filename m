Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272705AbTHEM6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272718AbTHEM6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:58:52 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:28060 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S272705AbTHEM6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:58:22 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: skraw@ithnet.com
Date: Tue, 5 Aug 2003 14:57:43 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: decoded problem in 2.4.22-pre10
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <94429E25D11@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On  5 Aug 03 at 14:23, Stephan von Krawczynski wrote:
> > 
> > Hello Petr,
> > 
> > at this time I can't provide you with details or exact reporting as the box has
> > to be used for finding the 2.4.22-pre stability problem I see. And since the
> > crashes take quite some time to occur I cannot reboot and check out what's the
> > deal with the vmware modules.

One more thing. VMware creates file in /tmp, unlinks it, and then file 
gradually expands as VM is initialized, so it grews from 0 to your
guest memory size + videoram size + ~5MB, while at same time all portions
of that file are MAP_SHARED to several processes.

And at exit VMware does ftruncate(xxx,0) to throw away unneeded data,
preventing them from hitting disk on subsequent (f)sync(), and this 
ftruncate() happens while other processes which have mmapped file are
doing munmap or exit, finding dirty pages which have no
underlying storage anymore during cleanup...

Both these operations were observed to cause problems in the past -
- on startup long ago reiserfs had problems with grewing unlinked files,
on shutdown kernel's mm raced with ftruncate. Both these problems are
currently fixed, but maybe some other race appeared somewhere?
                                            Best regards,
                                                Petr Vandrovec
                                                

