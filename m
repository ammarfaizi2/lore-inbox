Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbUKPJSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbUKPJSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUKPJSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:18:45 -0500
Received: from canuck.infradead.org ([205.233.218.70]:40200 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261949AbUKPJSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:18:41 -0500
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Message-Id: <1100596704.2811.17.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 16 Nov 2004 10:18:24 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?ip=80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 10:08 +0100, Miklos Szeredi wrote:
> Linus,
> 
> I did send a pointer to the cleaned up patch, maybe this wasn't
> explicit enough:
> 
>   http://fuse.sourceforge.net/kernel_patches/fuse-2.1-2.6.10-rc2.patch
+static void request_wait_answer(struct fuse_req *req)
+{
+	spin_unlock(&fuse_lock);
+	wait_event(req->waitq, req->finished);
+	spin_lock(&fuse_lock);
+}

+	spin_lock(&fuse_lock);
+	req->out.h.error = -ENOTCONN;
+	if (fc->file) {
+		req->in.h.unique = get_unique(fc);		
+		list_add_tail(&req->list, &fc->pending);
+		wake_up(&fc->waitq);
+		request_wait_answer(req);
+		list_del(&req->list);
+	}
+	spin_unlock(&fuse_lock);

somehow I find dropping the lock and then doing a list_del() without any kind of verification very suspicious. 
Either you need the lock or you don't. If you do, the code is wrong. If you don't... don't take the lock :)




