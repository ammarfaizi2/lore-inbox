Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVFFKC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVFFKC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 06:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVFFKC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 06:02:56 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:2966 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261267AbVFFKCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 06:02:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:user-agent:cc:references:in-reply-to:mime-version:content-disposition:date:content-type:content-transfer-encoding:message-id;
        b=qvUZ9BQU4pHFR8JlnzD8X1KCSYFawijUsXNw6yDm8TLiX9V2Kg2OrXCCSisdfYPI1KsvAggEXyOSKFKwNohZLbaovDVhJTsDeqRk6pxJ1nRNW6C8vLgyM+jNH/1GQT3B97xl5haWNJJtAe6fmaxISg9T16yFlNvYqa2b4xNQNYE=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: ericvh@gmail.com
Subject: Re: v9fs-transport-modules.patch added to -mm tree
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200506060624.j566OYq4010573@shell0.pdx.osdl.net>
In-Reply-To: <200506060624.j566OYq4010573@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Disposition: inline
Date: Mon, 6 Jun 2005 14:06:43 +0400
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200506061406.44290.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added linux-kernel, sorry.

On Monday 06 June 2005 10:24, akpm@osdl.org wrote:
>      v9fs: transport modules

> --- /dev/null
> +++ 25-akpm/fs/9p/mux.c

> +static int xread(struct v9fs_session_info *v9ses, void *ptr, unsigned long sz)
> +{
> +	int rd = 0;
> +	int ret = 0;
> +	int readnum = 0;
> +	while (rd < sz) {
> +		ret = v9ses->transport->read(v9ses->transport, ptr, sz - rd);
> +		readnum++;
> +		if (ret <= 0) {
> +			dprintk(DEBUG_ERROR, "xread errno %d\n", ret);
> +			return ret;
> +		}
> +		rd += ret;
> +		ptr += ret;
> +	}
> +	return (rd);
> +}

readnum is needed for what?

> +/**
> + * read_message - read a full 9P2000 fcall packet
> + * @v9ses: session info structure
> + * @rcall: fcall structure to read into
> + * @rcalllen: size of fcall structure

This makes me think rcalllen == sizeof(struct v9fs_fcall) which is not true.

> +static int
> +read_message(struct v9fs_session_info *v9ses,
> +	     struct v9fs_fcall *rcall, int rcalllen)
> +{

> +	res = v9fs_deserialize_fcall(v9ses, size, data, v9ses->maxdata,
> +				     rcall, rcalllen);
> +
> +	kfree(data);
> +
> +	if (res == 0)
> +		return -ENOMEM;

v9fs_deserialize_fcall can return 0 if rcall->id in it is unknown. It's
not -ENOMEM.

> +static int v9fs_send(struct v9fs_session_info *v9ses, struct v9fs_rpcreq *req)
> +{

> +	ret =
> +	    v9fs_serialize_fcall(v9ses, tcall, data,
> +				 v9ses->maxdata + V9FS_IOHDRSZ);
> +	if (ret == 0) {
> +		ret = -ENOMEM;

See v9fs_deserialize_fcall wrt "bad msg type".

> +static int v9fs_recvproc(void *data)
> +{

> +	while (!kthread_should_stop() && err >= 0) {
> +		rcall = kmalloc(v9ses->maxdata + V9FS_IOHDRSZ, GFP_KERNEL);
> +		dprintk(DEBUG_MUX, "waiting for message\n");
> +		err = read_message(v9ses, rcall, v9ses->maxdata + V9FS_IOHDRSZ);

Unchecked kmalloc().

> --- /dev/null
> +++ 25-akpm/fs/9p/trans_sock.c

> +/**
> + * v9fs_tcp_init - initialize TCP socket
> + * @trans: private socket structure for mount
> + * @dev_name: mount target
> + * @data: mount options
> + *
> + */
> +
> +static int
> +v9fs_tcp_init(struct v9fs_session_info *v9ses, const char *addr, char *data)

Comment and arguments don't match.

> +/**
> + * v9fs_unix_init - initialize UNIX domain socket
> + * @trans: private socket info
> + * @dev_name: mount target
> + * @data: mount options
> + *
> + */
> +
> +static int
> +v9fs_unix_init(struct v9fs_session_info *v9ses, const char *dev_name,
> +	       char *data)

Comment and arguments don't match.
