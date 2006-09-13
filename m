Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWIMN3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWIMN3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 09:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWIMN3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 09:29:36 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:25767 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750803AbWIMN3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 09:29:35 -0400
Date: Wed, 13 Sep 2006 15:29:34 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: select() and poll() inconsistency in writability test
Message-ID: <20060913132934.GA637@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A pipe without readers will yield EPIPE/SIGPIPE when trying to write()
into. A broken or shutdown TCP connection will behave the same modulo
networking errors (which are returned only once as it seems).

A pipe without readers will set POLLERR in pipe_poll() and this turns
up as being writable according to select() so it won't wait. However, a
TCP connection no longer open [for writing] does not set POLLERR/POLLOUT
in tcp_poll(): so it is not yet writable according to select() causing it
to wait. This is not consistent behavior.

Shouldn't the kernel set POLLOUT in both "EPIPE" cases instead of
POLLERR/nothing as it does now?

-- 
Frank
