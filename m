Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUFNRzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUFNRzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUFNRzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:55:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:37074 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263626AbUFNRzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:55:02 -0400
Subject: __user and iov_base
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM
Message-Id: <1087235597.10368.12.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Jun 2004 12:53:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The commonly used kernel structure iovec includes a field iov_base which
is:
	void __user *iov_base

Unfortunately some of the places that use this are sockets calls from
kernel code in which it would be awkward to do extra memcpy to a user
buffer (from a kernel buffer, perhaps created in a different process)
just to avoid a sparse warning.   Although it works fine to set
	myiovec.iov_base = (char *)some_buffer; 
this generates a warning message in the sparse tool since iov_base
includes the __user modifier, and the kernel buffer you are sending does
not..

If a buffer is never used in user space, and is potentially recycled
(via mempools) for use by more than one process, then it can't be passed
around as an __user buffer, but is it ok to simply do
	myiovec.iov_base = (__user char *)some_buffer; 
or is there another preferred way to handle kernel to __user
mappings/casts?

For the cifs vfs this would eliminate the last sparse warnings. 
	

