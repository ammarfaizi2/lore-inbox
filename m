Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUJWHnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUJWHnU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 03:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUJWHnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 03:43:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51353 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264503AbUJWHnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 03:43:17 -0400
Date: Sat, 23 Oct 2004 00:42:52 -0700
From: Paul Jackson <pj@sgi.com>
To: Jim Nelson <james4765@verizon.net>
Cc: rlrevell@joe-job.com, kwall@kurtwerks.com, linux-kernel@vger.kernel.org
Subject: Re: mozilla-mail damage [was Re: [PATCH] Update to
 Documentation/ramdisk.txt - take 2]
Message-Id: <20041023004252.78eddf13.pj@sgi.com>
In-Reply-To: <4179DBA3.2000407@verizon.net>
References: <4179B7A9.6020205@verizon.net>
	<20041023021227.GF4368@kurtwerks.com>
	<1098498910.9092.8.camel@krustophenia.net>
	<1098501410.9092.36.camel@krustophenia.net>
	<4179DBA3.2000407@verizon.net>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, sendpatchset doesn't work with SMTP authentication, which my ISP uses, 

The underlying Python smtplib module has authentication support.

You could probably hack your private copy of sendpatchset by adding
something like the following line with hardcoded strings to call the
python smtp login() method with your ISP user id and password:


    try:
        s=smtplib.SMTP(smtpserver)
    except:
        print "%s: Oops - Cant connect to SMTP Server <%s>" % (cmd, smtpserver)
        sys.exit(1)

    s.set_debuglevel(0)
+   s.login("james4765@verizon.net", "my_not_so_secret_password")
    if not actually_send_message:


The above change is untested speculation - good luck.

A proper solution might involve adding an optional user login id string
to the sendpatchset control file entry for the SMTP server:

	SMTP: <smtp_server_ipaddr> [<authenticated_smtp_user_login_id>]

and if this extra field was present, interactively collecting the
password during use and making the above "s.login()" call.

You'd want to somehow avoid collecting the password more than once per
sendpatchset session.  Since the current code reconnects many times
to the smtp server (twice per patch. first to verify and then to
actually send the message), either rearrange the smtp connection
handling in the current code to reuse a single connection, or collect
the password once and remember it in a python variable to use for each
reconnect during an entire sendpatchset session.

Since I don't happen to need this, I'm at little risk for adding this
anytime soon.  If someone else wants to send me a nice pretty solution,
I'd update my master copy if I found the solution to my liking.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
