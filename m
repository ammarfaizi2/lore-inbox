Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129409AbRBSQsp>; Mon, 19 Feb 2001 11:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129517AbRBSQsZ>; Mon, 19 Feb 2001 11:48:25 -0500
Received: from HSE-Montreal-ppp103309.qc.sympatico.ca ([64.230.176.130]:45572
	"EHLO mx1.lcis.net") by vger.kernel.org with ESMTP
	id <S129409AbRBSQsO>; Mon, 19 Feb 2001 11:48:14 -0500
Date: Mon, 19 Feb 2001 11:47:42 -0500 (EST)
From: "Gord R. Lamb" <glamb@lcis.dyndns.org>
X-X-Sender: <glamb@localhost.localdomain>
To: Anton Blanchard <anton@linuxcare.com.au>
cc: Jeremy Jackson <jeremy.jackson@sympatico.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Samba performance / zero-copy network I/O
In-Reply-To: <20010217191746.B2484@linuxcare.com>
Message-ID: <Pine.LNX.4.32.0102191145260.825-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, Anton Blanchard wrote:

>
> > Hmm.  Yeah, I think that may be one of the problems (Intel's card isn't
> > supported afaik; if I have to I'll switch to 3com, or hopelessly try to
> > implement support).  I'm looking for a patch to implement sendfile in
> > Samba, as Alan suggested.  That seems like a good first step.
>
> As Alan said, the smb protocol is pretty ugly. This patch makes samba use
> sendfile for unchained read_and_X replies. I could hook this into some of
> the other *read* replies but this is the one smbtorture uses so it served my
> purpose.  Of course this is against the current CVS head, not some wimpy
> stable branch. :)
>
> I still need to write some code to make this safe (things will break badly
> if multiple clients hit the same file and one of them truncates at just the
> right time).
>
> In my tests, this only improved things by a couple of percent because we do
> so many other things than just serving files in real life (well if you can
> call netbench land real life).

Well, it made a big difference for me.  I grabbed an extra 10-20mb/sec!
Now I just need to work on coalescing some of the ethernet interrupts.
Thanks, Anton!

> Anton
>
> diff -u -u -r1.195 includes.h
> --- source/include/includes.h	2000/12/06 00:05:14	1.195
> +++ source/include/includes.h	2001/01/26 05:38:51
> @@ -871,7 +871,8 @@
>
>  /* default socket options. Dave Miller thinks we should default to TCP_NODELAY
>     given the socket IO pattern that Samba uses */
> -#ifdef TCP_NODELAY
> +
> +#if 0
>  #define DEFAULT_SOCKET_OPTIONS "TCP_NODELAY"
>  #else
>  #define DEFAULT_SOCKET_OPTIONS ""
> diff -u -u -r1.257 reply.c
> --- source/smbd/reply.c	2001/01/24 19:34:53	1.257
> +++ source/smbd/reply.c	2001/01/26 05:38:53
> @@ -2383,6 +2391,51 @@
>      END_PROFILE(SMBreadX);
>      return(ERROR(ERRDOS,ERRlock));
>    }
> +
> +#if 1
> +  /* We can use sendfile if it is not chained */
> +  if (CVAL(inbuf,smb_vwv0) == 0xFF) {
> +    off_t tmpoffset;
> +    struct stat buf;
> +    int flags = 0;
> +
> +    nread = smb_maxcnt;
> +
> +    fstat(fsp->fd, &buf);
> +    if (startpos > buf.st_size)
> +      return(UNIXERROR(ERRDOS,ERRnoaccess));
> +    if (nread > (buf.st_size - startpos))
> +       nread = (buf.st_size - startpos);
> +
> +    SSVAL(outbuf,smb_vwv5,nread);
> +    SSVAL(outbuf,smb_vwv6,smb_offset(data,outbuf));
> +    SSVAL(smb_buf(outbuf),-2,nread);
> +    CVAL(outbuf,smb_vwv0) = 0xFF;
> +    set_message(outbuf,12,nread,False);
> +
> +#define MSG_MORE 0x8000
> +    if (nread > 0)
> +       flags = MSG_MORE;
> +    if (send(smbd_server_fd(), outbuf, data - outbuf, flags) == -1)
> +      DEBUG(0,("reply_read_and_X: send ERROR!\n"));
> +
> +    tmpoffset = startpos;
> +    while(nread) {
> +    	int nwritten;
> +	nwritten = sendfile(smbd_server_fd(), fsp->fd, &tmpoffset, nread);
> +	if (nwritten == -1)
> +	  DEBUG(0,("reply_read_and_X: sendfile ERROR!\n"));
> +
> +	if (!nwritten)
> +		break;
> +
> +	nread -= nwritten;
> +    }
> +
> +    return -1;
> +  }
> +#endif
> +
>    nread = read_file(fsp,data,startpos,smb_maxcnt);
>
>    if (nread < 0) {
>

