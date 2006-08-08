Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWHHKMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWHHKMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWHHKMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:12:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49313 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964786AbWHHKMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:12:18 -0400
Date: Tue, 8 Aug 2006 11:12:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] unserialized task->files changing
Message-ID: <20060808101208.GA25956@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44D86275.2080406@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D86275.2080406@sw.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 02:07:49PM +0400, Kirill Korotaev wrote:
> Fixed race on put_files_struct on exec with proc.
> Restoring files on current on error path may lead
> to proc having a pointer to already kfree-d files_struct.

This is three times the exact same code sequence, it should probably go into
a helper:

void reset_current_files(struct files_struct *files)
{
	struct files_struct *old = current->files;

	task_lock(current);
	current->files = files;
	task_unlock(current);
	put_files_struct(old);
}

