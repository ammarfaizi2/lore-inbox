Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVBOAyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVBOAyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVBOAyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:54:47 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:1207 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261467AbVBOAyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:54:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Pty is losing bytes
From: Andreas Schwab <schwab@suse.de>
X-Yow: My polyvinyl cowboy wallet was made in Hong Kong by Montgomery Clift!
Date: Tue, 15 Feb 2005 01:54:25 +0100
Message-ID: <jebramy75q.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent kernel are losing bytes on a pty.  Try running this program (needs
to be linked against -lutil) with a moderately large input (10K - 20K).
The output should match its input, but instead there is always one byte
missing at the end of the first 4K chunk read by the child.

#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pty.h>
#include <sys/wait.h>

char buf[4096];

int main (void)
{
    int master;
    int stdout = dup (1);
    int pid = forkpty (&master, 0, 0, 0);
    int bytes_read;
    int bytes_written;

    if (pid < 0) exit (1);
    if (pid > 0) {
        while ((bytes_read = read (0, buf, sizeof (buf))) > 0) {
            char *p = buf;
            while (bytes_read > 0 &&
                   (bytes_written = write (master, p, bytes_read)) > 0)
              bytes_read -= bytes_written, p += bytes_written;
        }
        write (master, "EOF\n", 4);
        waitpid (pid, 0, 0);
        exit (0);
    }

    while ((bytes_read = read (0, buf, sizeof (buf))) > 0) {
        char *p = buf;
        if (strncmp (buf, "EOF\n", 4) == 0) break;
        while (bytes_read > 0 &&
               (bytes_written = write (stdout, p, bytes_read)) > 0)
          bytes_read -= bytes_written, p += bytes_written;
    }
    exit (0);
}

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
