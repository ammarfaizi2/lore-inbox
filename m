Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbUBYUfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUBYUfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:35:38 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:10337 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261441AbUBYUfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:35:04 -0500
Date: Wed, 25 Feb 2004 22:36:59 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, Brian King <brking@us.ibm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Question on MODULE_VERSION macro
Message-ID: <20040225213659.GA9985@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Sam Ravnborg <sam@ravnborg.org>, Brian King <brking@us.ibm.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040223211718.GA7610@mars.ravnborg.org> <20040224110724.0FA0D2C0CE@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224110724.0FA0D2C0CE@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty.

I have not yet fully understood why you want to parse every source file.
I can see in the implemntation that you only calculate the sum of
code-lines, and not comments.
But why do we want to add this complexity - compared to just
calculating the sum of the whole file?
If the calculated sum is being presented as based on the source code
I assume people can understand that the sum does not match even after
updating a comment.

The current implementation fails to locate include files in the local
directory when compiled using "make O=...".
This is due to the fact that some files are present in the _deps
file with full path, others with relative path.

Example:
  /home/sam/bk/v2.6/drivers/scsi/aic7xxx/aiclib.h \
  /home/sam/bk/v2.6/drivers/scsi/aic7xxx/aic7xxx.h \
    $(wildcard include/config/used.h) \
  drivers/scsi/aic7xxx/aic7xxx_reg.h \
  /home/sam/bk/v2.6/drivers/scsi/aic7xxx/aic7xxx_inline.h \


I took a quick look and cannot explain why gcc spits out include files
with different paths.

My next question. Since we only parse a subset of the headers, is it
really needed to parse any of them?
My thinking is that we should either:
a) parse all header files (except those marked with $(wildcard))
b) parse no header files.

See also a few specific comments below.

	Sam

> +/* We have dir/file.o.  Open dir/.file.o.cmd, look for deps_ line to
> + * figure out source file. */
> +static int parse_source_files(const char *objfile, struct md4_ctx *md)
> +{
> +	char *cmd, *file, *p, *end;
> +	const char *base;
> +	unsigned long flen;
> +	int dirlen, ret = 0;
> +
> +	cmd = malloc(strlen(objfile) + sizeof("..cmd"));

You miss a "+ 1" to count for trailing '\0'.

> +
> +	base = strrchr(objfile, '/');
> +	if (base) {
> +		base++;
> +		dirlen = base - objfile;
> +		sprintf(cmd, "%.*s.%s.cmd", dirlen, objfile, base);
> +	} else {
> +		dirlen = 0;
> +		sprintf(cmd, ".%s.cmd", objfile);
> +	}
> +
> +	file = grab_file(cmd, &flen);
> +	if (!file) {
> +		fprintf(stderr, "Warning: could not find %s for %s\n",
> +			cmd, objfile);
> +		goto out;
> +	}
> +
> +	/* There will be a line like so:
> +		deps_drivers/net/dummy.o := \
> +		  drivers/net/dummy.c \
> +		    $(wildcard include/config/net/fastroute.h) \
> +		  include/linux/config.h \
> +		    $(wildcard include/config/h.h) \
> +		  include/linux/module.h \
> +
> +	   Sum all files in the same dir or subdirs.
> +	*/
> +	/* Strictly illegal: file is not nul terminated. */
> +	p = strstr(file, "\ndeps_");
> +	if (!p) {
> +		fprintf(stderr, "Warning: could not find deps_ line in %s\n",
> +			cmd);
> +		goto out_file;
> +	}
> +	p = strstr(p, ":=");
> +	if (!p) {
> +		fprintf(stderr, "Warning: could not find := line in %s\n",
> +			cmd);
> +		goto out_file;
> +	}
> +	p += strlen(":=");
> +	p += strspn(p, " \\\n");
> +
> +	end = strstr(p, "\n\n");
> +	if (!end) {
> +		fprintf(stderr, "Warning: could not find end line in %s\n",
> +			cmd);
> +		goto out_file;
> +	}
> +
> +	while (p < end) {
> +		unsigned int len;
> +
> +		len = strcspn(p, " \\\n");
> +		if (memcmp(objfile, p, dirlen) == 0) {
> +			char source[len + 1];
gcc extension, you do not want to use malloc here?

> +
> +			memcpy(source, p, len);
> +			source[len] = '\0';
> +			printf("parsing %s\n", source);
Debug printf - to be deleted.

> +			if (!parse_file(source, md)) {
> +				fprintf(stderr,
> +					"Warning: could not open %s: %s\n",
> +					source, strerror(errno));
> +				goto out_file;
> +			}
> +		}
> +		p += len;
> +		p += strspn(p, " \\\n");
> +	}
> +
> +	/* Everyone parsed OK */
> +	ret = 1;
> +out_file:
> +	release_file(file, flen);
> +out:
> +	free(cmd);
> +	return ret;
> +}
