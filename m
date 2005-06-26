Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVFZR1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVFZR1F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 13:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVFZR1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 13:27:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21380 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261488AbVFZRZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 13:25:27 -0400
Date: Sun, 26 Jun 2005 18:25:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Hans Reiser <reiser@namesys.com>, Alexander Zarochentsev <zam@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, reiserfs-list@namesys.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Message-ID: <20050626172520.GA19630@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Artem B. Bityuckiy" <dedekind@oktetlabs.ru>,
	Hans Reiser <reiser@namesys.com>,
	Alexander Zarochentsev <zam@namesys.com>,
	Jeff Garzik <jgarzik@pobox.com>, reiserfs-list@namesys.com,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <200506221824.32995.zam@namesys.com> <20050622142947.GA26993@infradead.org> <42BA2ED5.6040309@namesys.com> <20050626164606.GA18942@infradead.org> <42BEE0B4.3030804@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BEE0B4.3030804@oktetlabs.ru>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 09:07:00PM +0400, Artem B. Bityuckiy wrote:
> Just out of curiosity, could you please specify few exact examples with 
> specific file/function names which duplicate the existing 
> infrastructure. What do they duplicate and why? How should these 
> functions be implemented on VFS? Ho should the the other FSes 
> implement/ignore them? Why are you shure they will fit VFS well? etc.

Right now every file/inode/etc method in reiser4 is just a trivial
wrapper around a plugin call.  It should instead just set the method
table directly in the plugin initialization.  Example:

static int
reiser4_permission(struct inode *inode /* object */ ,
                   int mask,    /* mode bits to check permissions
                                 * for */
                   struct nameidata *nameidata)
{
	/* reiser4_context creation/destruction removed from here,
	   because permission checks currently don't require this.

           Permission plugin have to create context itself if necessary. */
	assert("nikita-1687", inode != NULL);

	return perm_chk(inode, mask, inode, mask);
}

besides a useless assert we just call into perm_chk, which is a macro
obsfucation to call generic_permission which would be called if
->permission was zero.  A hypothetical reiser4 "plugin" that would need
redefine ->permission would just override it in a set inode_operations.
