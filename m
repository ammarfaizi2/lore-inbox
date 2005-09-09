Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbVIIKqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVIIKqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVIIKqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:46:12 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:2492 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1030231AbVIIKqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:46:11 -0400
Message-ID: <432167F1.8020902@vc.cvut.cz>
Date: Fri, 09 Sep 2005 12:46:09 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?sch=F6nfeld_/_in-medias-res?= 
	<schoenfeld@in-medias-res.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ncpfs: Connection invalid / Input-/Output Errors
References: <S932080AbVIGI45/20050907085657Z+286@vger.kernel.org>	 <431ECA16.8040104@in-medias-res.com> <1126095079.28456.18.camel@imp.csi.cam.ac.uk> <431EF5CD.9050006@in-medias-res.com> <431F143F.2070904@vc.cvut.cz> <43213B7E.9050207@in-medias-res.com>
In-Reply-To: <43213B7E.9050207@in-medias-res.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schönfeld / in-medias-res wrote:
> Hi Petr,
> 
> the two servers is that the one with the problems does run a nagios nrpe
> server and some plugins, e.g. to check disk space on the novell disk,
> while the other server does not. Now i found that heavy operations on
> the filesystem (e.g. stat'ing many small files in a short time) is a
> kind of problematic, if you want to do anything else on the filesystem
> at the same time. The second process just hangs until the first one
> accessing the ncp filesystem is ready with its operation. Well if

You need either another CPU, or semaphore which do not suffer from starvation.
Or you have to rewrite ncpfs to use some queue instead of simple
semaphore.  What happens is that your copy process in a loop acquires
ncp_server's semaphore, sends request to server, waits for response, and
releases semaphore.  It does that for every request sent out.  Now your
process comes in, finds that ncp_server's semaphore is locked, and starts
waiting.  Other process gets answer from server, releases semaphore, and
as both processes were just waiting before this happened, they both have
same priority, and so one which just did up() continues to run.  And
before waken up process gets chance to do its task, copy process sends
another request, and so your second process goes to sleep again.
							Petr

