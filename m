Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317991AbSGWIJt>; Tue, 23 Jul 2002 04:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317990AbSGWIJt>; Tue, 23 Jul 2002 04:09:49 -0400
Received: from mail.webmaster.com ([216.152.64.131]:60313 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317988AbSGWIJs> convert rfc822-to-8bit; Tue, 23 Jul 2002 04:09:48 -0400
From: David Schwartz <davids@webmaster.com>
To: <davem@redhat.com>, <niemayer@isg.de>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1055) - Licensed Version
Date: Tue, 23 Jul 2002 01:12:56 -0700
In-Reply-To: <20020722.195749.34129476.davem@redhat.com>
Subject: Re: read/recv sometimes returns EAGAIN instead of EINTR on SMP machines
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020723081257.AAA26793@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002 19:57:49 -0700 (PDT), David S. Miller wrote:
>From: Peter Niemayer <niemayer@isg.de>
>Date: Mon, 22 Jul 2002 12:43:14 +0200

>If one process tries to read non-blocking from a tcp socket (domain sockets
>work
>fine), and another process sends the reading process signals, then
>sometimes
>select() returns with the indication that the socket is readable,
>but the subsequent read returns EAGAIN - instead of EINTR which
>would have been the correct return code. This only happenes on SMP
>machines.

>I think EAGAIN is the correct return value.  This behavior has been
>there since the stone ages of TCP and I remember Alan specifically
>auditing all of this stuff long ago wrt. POSIX compliance.

	EAGAIN is the correct value unless the read/recv was itself interrupted by a 
signal. However, the 'select' should not indicate that the socket is readable 
unless there is something to read (or an error, or whatnot). When 'select' is 
interrupted by a signal, select should return EINTR.

	My guess is that select did return EINTR, but for some reason your 
application examined the fd sets anyway. So the bug is in not ignoring the fd 
sets when select returns an error, which is an application issue.

	Most likely, 'select' never got around to touching the fd sets at all.

	DS


