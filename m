Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946602AbWKAGLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946602AbWKAGLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946547AbWKAGLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:11:10 -0500
Received: from 1wt.eu ([62.212.114.60]:60932 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1946602AbWKAGLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:11:08 -0500
Date: Wed, 1 Nov 2006 08:11:11 +0100
From: Willy Tarreau <w@1wt.eu>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 30/61] knfsd: Fix race that can disable NFS server.
Message-ID: <20061101071111.GB543@1wt.eu>
References: <20061101053340.305569000@sous-sol.org> <20061101054028.568862000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101054028.568862000@sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 09:34:10PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: NeilBrown <neilb@suse.de>
> 
> This is a long standing bug that seems to have only recently become
> apparent, presumably due to increasing use of NFS over TCP - many
> distros seem to be making it the default.
> 
> The SK_CONN bit gets set when a listening socket may be ready
> for an accept, just as SK_DATA is set when data may be available.
> 
> It is entirely possible for svc_tcp_accept to be called with neither
> of these set.  It doesn't happen often but there is a small race in
> svc_sock_enqueue as SK_CONN and SK_DATA are tested outside the
> spin_lock.  They could be cleared immediately after the test and
> before the lock is gained.
> 
> This normally shouldn't be a problem.  The sockets are non-blocking so
> trying to read() or accept() when ther is nothing to do is not a problem.
> 
> However: svc_tcp_recvfrom makes the decision "Should I accept() or
> should I read()" based on whether SK_CONN is set or not.  This usually
> works but is not safe.  The decision should be based on whether it is
> a TCP_LISTEN socket or a TCP_CONNECTED socket.
> 
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> 
> ---
>  net/sunrpc/svcsock.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.18.1.orig/net/sunrpc/svcsock.c
> +++ linux-2.6.18.1/net/sunrpc/svcsock.c
> @@ -902,7 +902,7 @@ svc_tcp_recvfrom(struct svc_rqst *rqstp)
>  		return 0;
>  	}
>  
> -	if (test_bit(SK_CONN, &svsk->sk_flags)) {
> +	if (svsk->sk_sk->sk_state == TCP_LISTEN) {
>  		svc_tcp_accept(svsk);
>  		svc_sock_received(svsk);
>  		return 0;

This one seems valid for 2.4 too. Neil, do you confirm ?

Willy

