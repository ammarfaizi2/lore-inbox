Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWHHKXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWHHKXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWHHKXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:23:13 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:8353 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S964779AbWHHKXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:23:13 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] unserialized task->files changing
Date: Tue, 8 Aug 2006 12:23:09 +0200
User-Agent: KMail/1.9.1
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44D86275.2080406@sw.ru> <20060808101208.GA25956@infradead.org>
In-Reply-To: <20060808101208.GA25956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081223.10434.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 12:12, Christoph Hellwig wrote:
> On Tue, Aug 08, 2006 at 02:07:49PM +0400, Kirill Korotaev wrote:
> > Fixed race on put_files_struct on exec with proc.
> > Restoring files on current on error path may lead
> > to proc having a pointer to already kfree-d files_struct.
>
> This is three times the exact same code sequence, it should probably go
> into a helper:
>
> void reset_current_files(struct files_struct *files)
> {
> 	struct files_struct *old = current->files;
>
> 	task_lock(current);
> 	current->files = files;
> 	task_unlock(current);
> 	put_files_struct(old);
> }


More over I think you want to task_lock() before reading current->files 
into 'old'

task_lock(current);
old = current->files;
current->files = files;
task_unlock(current);
put_files_struct(old);

or maybe a xchg() ?

