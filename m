Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbUKKWpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbUKKWpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUKKWnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:43:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:53383 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262401AbUKKWmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:42:02 -0500
Date: Thu, 11 Nov 2004 14:41:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: 2.6.10-rc1-mm5
Message-Id: <20041111144153.588094d2.akpm@osdl.org>
In-Reply-To: <111920000.1100210158@flay>
References: <20041111012333.1b529478.akpm@osdl.org>
	<20041111030837.12a2090b.akpm@osdl.org>
	<111920000.1100210158@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
>  That works. But something broke shmem:
> 
>  ipc/shm.c:171: error: `shmem_set_policy' undeclared here (not in a function)
>  ipc/shm.c:171: error: initializer element is not constant
>  ipc/shm.c:171: error: (near initialization for `shm_vm_ops.set_policy')
>  ipc/shm.c:172: error: `shmem_get_policy' undeclared here (not in a function)
>  ipc/shm.c:172: error: initializer element is not constant
>  ipc/shm.c:172: error: (near initialization for `shm_vm_ops.get_policy')

OK, I tracked this down to another secret dhowells diff.

 config SHMEM
-       default y
-       bool "Use full shmem filesystem" if EMBEDDED && MMU
+       bool "Use full shmem filesystem"
+       default y if EMBEDDED
+       depends on MMU

This change permits CONFIG_SHMEM=n on !CONFIG_MMU, even if !EMBEDDED.  Or
something.  I'm not really sure what it's trying to do, nor am I clear on
what semantics we wanted to have for CONFIG_SHMEM on CONFIG_MMU machines.

I think the semantics we want are: you always get shmem, unless you
selected EMBEDDED.  So perhaps we want:

config SHMEM
	bool "Use full shmem filesystem" if EMBEDDED
	depends on MMU
	default y if MMU


