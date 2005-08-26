Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVHZPdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVHZPdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVHZPdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:33:06 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30682 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965078AbVHZPdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:33:05 -0400
Message-Id: <200508261531.j7QFVdtc015132@laptop11.inf.utfsm.cl>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Brian Gerst <bgerst@didntduck.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH 3/3] exterminate strtok - usr/gen_init_cpio.c 
In-Reply-To: Message from Jesper Juhl <jesper.juhl@gmail.com> 
   of "Wed, 24 Aug 2005 23:14:40 +0200." <200508242314.41324.jesper.juhl@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 26 Aug 2005 11:31:39 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 26 Aug 2005 11:31:41 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On Wednesday 24 August 2005 22:39, Brian Gerst wrote:
> > 
> > Do this instead:
> > 	char ln[LINE_SIZE], *line;
> > 
> Right, now why didn't I think of that :)
> 
> Jeff: Does the patch below agree with you more?
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  usr/gen_init_cpio.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)
>  
>  --- linux-2.6.13-rc6-mm2-orig/usr/gen_init_cpio.c	2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6.13-rc6-mm2/usr/gen_init_cpio.c	2005-08-24 23:10:36.000000000 +0200
> @@ -438,7 +438,8 @@ struct file_handler file_handler_table[]
>  int main (int argc, char *argv[])
>  {
>  	FILE *cpio_list;
> -	char line[LINE_SIZE];
> +	char ln[LINE_SIZE];
> +	char *line;
>  	char *args, *type;
>  	int ec = 0;
>  	int line_nr = 0;
> @@ -455,7 +456,7 @@ int main (int argc, char *argv[])
>  		exit(1);
>  	}
>  
> -	while (fgets(line, LINE_SIZE, cpio_list)) {
> +	while (line = ln, fgets(line, LINE_SIZE, cpio_list)) {
>  		int type_idx;
>  		size_t slen = strlen(line);

The ',' in the while() isn't exactly readable... first order of bussiness
inside:

	while (fgets(line, LINE_SIZE, cpio_list)) {
	while (fgets(ln, LINE_SIZE, cpio_list)) {
		int type_idx;
		size_t slen = strlen(ln);

		line = ln;

Or just use the fact that fgets(3) returns the buffer if no error:

	while(line = fgets(ln, LINE_SIZE, cpio_list)) {

(yes, gcc will complain... wrap in () to shut it up)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
