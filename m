Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVISUxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVISUxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVISUxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:53:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:20609 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932335AbVISUxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:53:12 -0400
X-Authenticated: #271361
Date: Mon, 19 Sep 2005 22:53:05 +0200
From: Edgar Toernig <froese@gmx.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc1 wait()/SIG_CHILD bevahiour
Message-Id: <20050919225305.797b5e9d.froese@gmx.de>
In-Reply-To: <1127151573.1586.14.camel@dyn9047017102.beaverton.ibm.com>
References: <1127151573.1586.14.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
>
> I am looking at a problem where the parent process doesn't seem 
> to cleanup the exited children (with a webserver). We narrowed it
> down to a simple testcase. Seems more like a lost SIG_CHILD.

You are aware that the defunct processes are all grandchildren
and the sigchild handler of the children is the one inherited from
the main process?  That sighandler is pretty bogus for the children,
i.e. pid_exited never does anything useful.  Further, the children
terminate unconditionally after some time - all still present grand-
children are inherited by init (pid 1) who does the clean up.

But I think the major problem is that the main-loop of the children
and the signal handler both call usleep(rand()) - I wouldn't be
surprised if this combo isn't reentrant, especially from signal
handlers ...

Ciao, ET.
