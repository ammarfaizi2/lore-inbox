Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTEZNQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTEZNQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:16:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8668 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264374AbTEZNQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:16:51 -0400
Date: Mon, 26 May 2003 15:29:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] [2.5 patch] Change strlcpy and strlcat
Message-ID: <20030526132955.GC9104@fs.tum.de>
References: <20030525112150.3994df9b.l.s.r@web.de> <3ED0FC58.D1F04381@gmx.de> <20030525210509.09429aaa.l.s.r@web.de> <1053911585.367899@palladium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1053911585.367899@palladium.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 01:13:05AM +0000, Linus Torvalds wrote:
> In article <20030525210509.09429aaa.l.s.r@web.de>,
> René Scharfe  <l.s.r@web.de> wrote:
> >
> >Anyway, I corrected this. Patch below contains a "BSD-compatible" version,
> >and also a strlcat().
> 
> Ok, I did my own versions, since (a) I had already started and your
> patches wouldn't apply, and (b) I hate adding a zillion lines of extra
> copyright notices for a 5-line function and (c) I think your patch had
> EXPORT_SYMBOL wrong.
> 
> In particular, if any architecture ever decides to roll their own
> version of strlcpy/strlcat, the EXPORT_SYMBOL() in ksyms.c would be the
> wrong thing to do. 
> 
> The current BK tree has my totally untested versions of these functions
> ("Famous last words: 'how hard can it be?'"), along with what I think
> is the proper way to export them.

Your API is compatible with *BSD but I'm wondering whether something 
slightly different might make error handling for callers easier:

Currently strlcpy returns the total length of the string it tried to 
create, whether it was too long or not. This means a check whether the 
complete string was copied is always something like

  if (strlcpy(dest, src, sizeof(dest)) >= sizeof(dest))
      goto toolong;

If strlcpy would return 0 for successful copies this would simplify to

  if (!strlcpy(dest, src, sizeof(dest)))
      goto toolong;


A patch is below.

I've tested only the compilation, any comments are welcome.


Another possible change to the semantics might be to copy/cat only if
dest is big enough to make error handling especially in the case of
strlcat easier (without additional information it's currently impossible
to get the original contents of dest if only parts of src were copied).


> 			Linus

cu
Adrian


--- linux-2.5.69/lib/string.c.old	2003-05-26 11:29:21.000000000 +0200
+++ linux-2.5.69/lib/string.c	2003-05-26 15:19:56.000000000 +0200
@@ -102,20 +102,30 @@
  * @src: Where to copy the string from
  * @size: size of destination buffer
  *
- * Compatible with *BSD: the result is always a valid
+ * Similar to *BSD: the result is always a valid
  * NUL-terminated string that fits in the buffer (unless,
  * of course, the buffer size is zero). It does not pad
- * out the result like strncpy() does.
+ * out the result like strncpy() does. Unlike *BSD it
+ * returns 0 for a successful copy.
  */
 size_t strlcpy(char *dest, const char *src, size_t size)
 {
 	size_t ret = strlen(src);
+	size_t len;
+
+	if (!size)
+		return 0;
+
+	if (ret >= size)
+		len = size - 1;
+	else {
+		len = ret;
+		ret = 0;
+		}
+
+	memcpy(dest, src, len);
+	dest[len] = '\0';
 
-	if (size) {
-		size_t len = (ret >= size) ? size-1 : ret;
-		memcpy(dest, src, len);
-		dest[len] = '\0';
-	}
 	return ret;
 }
 EXPORT_SYMBOL(strlcpy);
@@ -175,23 +185,33 @@
  * @dest: The string to be appended to
  * @src: The string to append to it
  * @count: The size of the destination buffer.
+ *
+ * Returns 0 if successful, the number of bytes needed in dest
+ * otherwise.
  */
 size_t strlcat(char *dest, const char *src, size_t count)
 {
 	size_t dsize = strlen(dest);
 	size_t len = strlen(src);
-	size_t res = dsize + len;
+	size_t ret;
 
 	/* This would be a bug */
 	BUG_ON(dsize >= count);
 
 	dest += dsize;
 	count -= dsize;
+
 	if (len >= count)
-		len = count-1;
+		{
+		ret = dsize + len;
+		len = count - 1;
+		}
+	else
+		ret = 0;
+
 	memcpy(dest, src, len);
-	dest[len] = 0;
-	return res;
+	dest[len] = '\0';
+	return ret;
 }
 EXPORT_SYMBOL(strlcat);
 #endif
