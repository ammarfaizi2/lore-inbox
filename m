Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132738AbRDRGKK>; Wed, 18 Apr 2001 02:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132753AbRDRGKA>; Wed, 18 Apr 2001 02:10:00 -0400
Received: from thorin.y.ics.muni.cz ([147.251.61.126]:60942 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S132738AbRDRGJu>; Wed, 18 Apr 2001 02:09:50 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Wed, 18 Apr 2001 08:09:46 +0200
To: Wolfgang Rohdewald <WRohdewald@dplanet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010418080946.E2167@informatics.muni.cz>
In-Reply-To: <20010417170206.C2589096@informatics.muni.cz> <20010417161036.A21620@bastard.inflicted.net> <20010417223636.C2167@informatics.muni.cz> <20010417212249.D0552C24B@poboxes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010417212249.D0552C24B@poboxes.com>; from WRohdewald@dplanet.ch on Tue, Apr 17, 2001 at 11:22:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Rohdewald wrote:
: On Tuesday 17 April 2001 22:36, Jan Kasprzak wrote:
: > +    if (len == -1 || len > 0 && len < count) {
: 
: are you sure there are no missing () ?
: 
: if ((len == -1) || (len > 0) && (len < count)) {
: 
: assumig that && has precedence over || (I believe so)

	Yes, but the precedence of ==, <, and > is even higher.
However, I've found a problem with the previous patch: The first chunk should
read:

-    if((len = sendfile(session.d->outf->fd, retr_fd, offset, count)) == -1) {
+    len = sendfile(session.d->outf->fd, retr_fd, offset, count);
+    if (len == -1 || len > 0 && len < count) {
+       if (len != -1)
+              errno = EINTR;

i.e. we should not overwrite errno, when it is valid.

-Yenya

PS.: You can find the C operators precedence for example at
	http://www.howstuffworks.com/c14.htm (found by Google).

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
Mantra: "everything is a stream of bytes". Repeat until enlightened. --Linus
