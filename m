Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUD1T4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUD1T4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUD1Tyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:54:39 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:38081 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265034AbUD1SRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 14:17:34 -0400
Subject: Re: CIFS/SMBFS failing under load in 2.6.X
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM
Message-Id: <1083176191.4845.46.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Apr 2004 13:16:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Whenever I put a high load on CIFS or SMBFS requests timeout and 
> then the benchmark or whatever I run fails. I ran the same tests
> successfully with a 2.4.25 kernel

This should be ok on 2.6.6 let me kmow if you see any more stress
problems with cifs vfs.   The reconnection problems and readpages memory
leak were fixed quite a while ago in the cifs vfs (but not merged until
recently), and the problem with incomplete socket ops and incorrect
signal handling causing timeouts were fixed more recently - but both
should be in 2.6.6 (which includes a very large cifs update).

Also that with 2.6.6 the CIFS VFS will add support for NTv4 (although a
few of the posix options won't work due to lack of server support) which
may be helpful to some still.

Probably the most important performance optimization that will help some
of the popular stress scenarios, at this point at least, is implementing
cifs_writepages, and eliminating the extra memcpy in writepage.  dbench
performance is ok - but since it is heavily oriented towards writes and
writepage is overly serialized, with dbench cifs (and smbfs) gets only
about 1/3 of what I would consider a reasonable goal for maximum
achievable throughput to Samba (based on the tbench estimates for
maximum network throughput).

Interestingly there are a few microbenchmarks in which implementing
readpages and writepage can actually slow things down, but in general
the addition of readpages/writepage along with oplock (smb/cifs
distributed caching) support has been a big help.

Jeremy Allison and I are starting to work through some minor CIFS
dialect enhancements to help performance even more in the CIFS -> Samba
case and perhaps getting the spec written up nicely if there is
interest.

