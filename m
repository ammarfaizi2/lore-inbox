Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUCaQNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUCaQNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:13:45 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:14815 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262056AbUCaQNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:13:06 -0500
Date: Wed, 31 Mar 2004 09:13:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/22] Add __early_param for all arches
Message-ID: <20040331161305.GK13819@smtp.west.cox.net>
References: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain> <1080706985.29195.12.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080706985.29195.12.camel@bach>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 02:23:05PM +1000, Rusty Russell wrote:

> On Thu, 2004-03-25 at 10:57, trini@kernel.crashing.org wrote: 
> > +void __init parse_early_options(char **cmdline_p)
> 
> Please, don't do it this way.
> 
> __setup() has icky semantics which are only used in three places (ide,
> ppc64's eeh, and um's eth).  The string is a prefix and the rest of the
> parameter is handed to the fn as an arg.  Meaning misspellings aren't
> usually caught, and accidental name reuse is hard to catch.
> 
> Secondly, we already have a parser in the kernel.
> 
> I like the idea of cleaning up saved_command_line crap: ideally
> the archs would just assign to a global "command_line" var, and
> anyone wanting to write to it would make their own copies.
> 
> How's this version, instead?  If you agree, I'll produce a merged
> version.

My first concern is can parse_args & co really be run so very early on ?
Also:
> +/* Arch code calls this early on. */
> +void __init parse_early_options(const char *saved_command_line)
> +{
> +	static char __initdata command_line[COMMAND_LINE_SIZE];
> +	strcpy(command_line, saved_command_line);

Really should be:
/* i386 goes right to saved_command_line */
if (*cmdline_p != saved_command_line)
	memcpy(saved_command_line, *cmdline_p, COMMAND_LINE_SIZE);
/* ensure NUL terminated. */
saved_command_line[COMMAND_LINE_SIZE - 1] = '\0';

-- 
Tom Rini
http://gate.crashing.org/~trini/
