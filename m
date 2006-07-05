Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWGERDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWGERDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWGERDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:03:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964907AbWGERDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:03:34 -0400
Date: Wed, 5 Jul 2006 10:03:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Sam Ravnborg <sam@ravnborg.org>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, bernds_cb1@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] FRV: Introduce asm-offsets for FRV arch
In-Reply-To: <1152117585.2987.21.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.64.0607050956020.12404@g5.osdl.org>
References: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com>
  <20060705132419.31510.92219.stgit@warthog.cambridge.redhat.com> 
 <20060705144138.GA26545@mars.ravnborg.org> <1152117585.2987.21.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jul 2006, David Woodhouse wrote:
> 
> (It still sucks that I have to give both URLs because we can't use just
> one for both pulling and browsing).

Hey, if you are willing to add some manual redirection to your gitweb 
setup, you could _probably_ do something like the appended..

(This is totally untested, but you get the idea - teach gitweb to export 
a "git_redirect" file at the top of the repo name, and teach "git fetch" 
to look if that exists and use another repo if so)

		Linus
---
diff --git a/git-fetch.sh b/git-fetch.sh
index 48818f8..e3c880c 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -267,12 +267,22 @@ fetch_main () {
 
       rref="$rref$LF$remote_name"
 
-      # There are transports that can fetch only one head at a time...
+      if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+	  curl_extra_args="-k"
+      fi
+
+      # See if we can turn http:// into git://
       case "$remote" in
       http://* | https://*)
-	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
-	      curl_extra_args="-k"
+	  redirect=$(curl -nsfL $curl_extra_args "$remote/git_redirect")
+	  if [ -n "$redirect" ]; then
+	    remote="$redirect"
 	  fi
+      esac
+
+      # There are transports that can fetch only one head at a time...
+      case "$remote" in
+      http://* | https://*)
 	  max_depth=5
 	  depth=0
 	  head="ref: $remote_name"
