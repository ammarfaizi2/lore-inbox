Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbULVAxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbULVAxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbULVAxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:53:43 -0500
Received: from mail.dif.dk ([193.138.115.101]:19179 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261930AbULVAwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:52:42 -0500
Date: Wed, 22 Dec 2004 02:03:22 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Domen Puncer <domen@coderock.org>
Cc: Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: [third patch version] Re: in cifssmb.c add copy_from_user return
 value check and do minor formatting/whitespace cleanups. 
In-Reply-To: <Pine.LNX.4.61.0412220107230.3518@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0412220157570.3518@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412220021580.3518@dragon.hygekrogen.localhost>
 <20041221235424.GA19274@nd47.coderock.org> <Pine.LNX.4.61.0412220107230.3518@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2004, Jesper Juhl wrote:

> On Wed, 22 Dec 2004, Domen Puncer wrote:
> 
> > On 22/12/04 00:33 +0100, Jesper Juhl wrote:
> > > 
> [...]
> > > +	if (buf) {
> > > +		memcpy(pSMB->Data,buf,bytes_sent);
> > > +	} else if (ubuf) {
> > > +		if (copy_from_user(pSMB->Data,ubuf,bytes_sent)) {
> > > +			if (pSMB)
> > 
> > How can this be NULL, and code not Oopsing?
> > 
> Right, it would have Oopsed in tons of places above if pSMB was NULL, so 
> there's no point in checking it at this stage. And if I'm reading 
> smb_init() correctly, then it will return an error if it can't give pSMB a 
> sane value, so we already bail out at the smb_init() call in that case.
> 
> How about this patch instead? (same as the previous one except it also 
> removes those aparently pointless checks of pSMB and changes a single 
> instance of a pointer being compared to 0 to instead compare against NULL 
> so sparse won't complain about that) :
> 
And if it is correct that those pSMB checks can go (and it certainly looks 
to me as if they can), then why not clean them out from the entire file? 
and while we are at it fix up a few lines that are seriously whitespace 
challenged as well.  That's what this third version does - same stuff as 
the first two, but with a few more whitespace cleanups and the (aparently) 
useless pSMB checks gone from the entire file.

Please review and consider for inclusion :-)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk13-orig/fs/cifs/cifssmb.c linux-2.6.10-rc3-bk13/fs/cifs/cifssmb.c
--- linux-2.6.10-rc3-bk13-orig/fs/cifs/cifssmb.c	2004-12-20 22:19:42.000000000 +0100
+++ linux-2.6.10-rc3-bk13/fs/cifs/cifssmb.c	2004-12-22 01:54:32.000000000 +0100
@@ -246,7 +246,7 @@ smb_init(int smb_command, int wct, struc
 		return rc;
 
 	*request_buf = cifs_buf_get();
-	if (*request_buf == 0) {
+	if (*request_buf == NULL) {
 		/* BB should we add a retry in here if not a writepage? */
 		return -ENOMEM;
 	}
@@ -409,8 +409,8 @@ CIFSSMBNegotiate(unsigned int xid, struc
 		}
 				
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
+
 	return rc;
 }
 
@@ -523,8 +523,7 @@ CIFSSMBLogoff(const int xid, struct cifs
 			rc = -ESHUTDOWN;
 		}
 	}
-	if (pSMB)
-		cifs_small_buf_release(pSMB);
+	cifs_small_buf_release(pSMB);
 	up(&ses->sesSem);
 
 	/* if session dead then we do not need to do ulogoff,
@@ -579,8 +578,7 @@ DelFileRetry:
         }
 #endif
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto DelFileRetry;
 
@@ -630,10 +628,10 @@ RmDirRetry:
         }
 #endif
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto RmDirRetry;
+
 	return rc;
 }
 
@@ -679,10 +677,10 @@ MkDirRetry:
 		atomic_inc(&tcon->num_mkdirs);
         }
 #endif
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto MkDirRetry;
+
 	return rc;
 }
 
@@ -780,10 +778,10 @@ openRetry:
 		atomic_inc(&tcon->num_opens);
 #endif
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto openRetry;
+
 	return rc;
 }
 
@@ -846,12 +844,10 @@ CIFSSMBRead(const int xid, struct cifsTc
 			    memcpy(*buf,pReadData,data_length);
 		}
 	}
-	if (pSMB) {
-		if(*buf)
-			cifs_buf_release(pSMB);
-		else
-			*buf = (char *)pSMB;
-	}
+	if(*buf)
+		cifs_buf_release(pSMB);
+	else
+		*buf = (char *)pSMB;
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 		since file handle passed in no longer valid */
@@ -895,15 +891,18 @@ CIFSSMBWrite(const int xid, struct cifsT
 		bytes_sent = count;
 	pSMB->DataLengthHigh = 0;
 	pSMB->DataOffset =
-	    cpu_to_le16(offsetof(struct smb_com_write_req,Data) - 4);
-    if(buf)
-	    memcpy(pSMB->Data,buf,bytes_sent);
-	else if(ubuf)
-		copy_from_user(pSMB->Data,ubuf,bytes_sent);
-    else {
-		/* No buffer */
-		if(pSMB)
+		cpu_to_le16(offsetof(struct smb_com_write_req,Data) - 4);
+
+	if (buf) {
+		memcpy(pSMB->Data,buf,bytes_sent);
+	} else if (ubuf) {
+		if (copy_from_user(pSMB->Data,ubuf,bytes_sent)) {
 			cifs_buf_release(pSMB);
+			return -EFAULT;
+		}
+	} else {
+		/* No buffer */
+		cifs_buf_release(pSMB);
 		return -EINVAL;
 	}
 
@@ -921,12 +920,10 @@ CIFSSMBWrite(const int xid, struct cifsT
 	} else
 		*nbytes = le16_to_cpu(pSMBr->Count);
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 		since file handle passed in no longer valid */
-
 	return rc;
 }
 
@@ -946,7 +943,7 @@ int CIFSSMBWrite2(const int xid, struct 
 	rc = small_smb_init(SMB_COM_WRITE_ANDX, 14, tcon, (void **) &pSMB);
 	pSMBr = (WRITE_RSP *)pSMB; /* BB removeme BB */
     
-    if (rc)
+	if (rc)
 		return rc;
 	/* tcon and ses pointer are checked in smb_init */
 	if (tcon->ses->server == NULL)
@@ -980,8 +977,7 @@ int CIFSSMBWrite2(const int xid, struct 
 	} else
 		*nbytes = le16_to_cpu(pSMBr->Count);
 
-	if (pSMB)
-		cifs_small_buf_release(pSMB);
+	cifs_small_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 		since file handle passed in no longer valid */
@@ -1046,8 +1042,7 @@ CIFSSMBLock(const int xid, struct cifsTc
 	if (rc) {
 		cFYI(1, ("Send error in Lock = %d", rc));
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 	since file handle passed in no longer valid */
@@ -1082,9 +1077,7 @@ CIFSSMBClose(const int xid, struct cifsT
 			cERROR(1, ("Send error in Close = %d", rc));
 		}
 	}
-
-	if (pSMB)
-		cifs_small_buf_release(pSMB);
+	cifs_small_buf_release(pSMB);
 
 	/* Since session is dead, file will be closed on server already */
 	if(rc == -EAGAIN)
@@ -1161,9 +1154,7 @@ renameRetry:
 	}
 #endif
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto renameRetry;
 
@@ -1241,12 +1232,11 @@ int CIFSSMBRenameOpenFile(const int xid,
 		atomic_inc(&pTcon->num_t2renames);
 	}
 #endif
-	if (pSMB)
-		cifs_buf_release(pSMB);
+
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls
 		since file handle passed in no longer valid */
-
 	return rc;
 }
 
@@ -1311,9 +1301,7 @@ copyRetry:
 		cFYI(1, ("Send error in copy = %d with %d files copied",
 			rc, le16_to_cpu(pSMBr->CopyCount)));
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto copyRetry;
 
@@ -1403,9 +1391,7 @@ createSymLinkRetry:
 		      rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto createSymLinkRetry;
 
@@ -1492,8 +1478,7 @@ createHardLinkRetry:
 		cFYI(1, ("Send error in SetPathInfo (hard link) = %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto createHardLinkRetry;
 
@@ -1564,8 +1549,7 @@ winCreateHardLinkRetry:
 	if (rc) {
 		cFYI(1, ("Send error in hard link (NT rename) = %d", rc));
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto winCreateHardLinkRetry;
 
@@ -1665,15 +1649,13 @@ querySymLinkRetry:
 	/* just in case so calling code does not go off the end of buffer */
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto querySymLinkRetry;
+
 	return rc;
 }
 
-
-
 int
 CIFSSMBQueryReparseLinkInfo(const int xid, struct cifsTconInfo *tcon,
 			const unsigned char *searchName,
@@ -1749,12 +1731,10 @@ CIFSSMBQueryReparseLinkInfo(const int xi
 			cFYI(1,("readlink result - %s ",symlinkinfo));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls
 		since file handle passed in no longer valid */
-
 	return rc;
 }
 
@@ -1969,10 +1949,10 @@ queryAclRetry:
 				buflen,acl_type,count);
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto queryAclRetry;
+
 	return rc;
 }
 
@@ -1996,7 +1976,8 @@ setAclRetry:
                       (void **) &pSMBr);
 	if (rc)
 		return rc;
-                                                                                                               	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
+
+	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
 			cifs_strtoUCS((wchar_t *) pSMB->FileName, fileName, PATH_MAX
 				/* BB fixme find define for this maxpathcomponent */
@@ -2049,11 +2030,11 @@ setAclRetry:
 	}
 
 setACLerrorExit:
-	if (pSMB)
-		cifs_buf_release(pSMB);
-                                                                                                            	if (rc == -EAGAIN)
+	cifs_buf_release(pSMB);
+	if (rc == -EAGAIN)
 		goto setAclRetry;
-                                                                                                           	return rc;
+	
+	return rc;
 }
 
 #endif
@@ -2133,8 +2114,7 @@ QPathInfoRetry:
 		} else
 		    rc = -ENOMEM;
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QPathInfoRetry;
 
@@ -2217,8 +2197,7 @@ UnixQPathInfoRetry:
 			       sizeof (FILE_UNIX_BASIC_INFO));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto UnixQPathInfoRetry;
 
@@ -2297,8 +2276,7 @@ findUniqueRetry:
 
 		/* BB fill in */
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto findUniqueRetry;
 
@@ -2406,9 +2384,7 @@ findFirstRetry:
 				le16_to_cpu(pSMBr->t2.DataCount));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto findFirstRetry;
 
@@ -2498,8 +2474,7 @@ findFirst2Retry:
 		/* BB Add code to handle unsupported level rc */
 		cFYI(1, ("Error in FindFirst = %d", rc));
 
-		if (pSMB)
-			cifs_buf_release(pSMB);
+		cifs_buf_release(pSMB);
 
 		/* BB eventually could optimize out free and realloc of buf */
 		/*    for this case */
@@ -2533,8 +2508,7 @@ findFirst2Retry:
 /*cFYI(1,("entries in buf %d index_of_last %d",psrch_inf->entries_in_buffer,psrch_inf->index_of_last_entry));  */
 			*pnetfid = parms->SearchHandle;
 		} else {
-			if(pSMB)
-				cifs_buf_release(pSMB);
+			cifs_buf_release(pSMB);
 		}
 	}
 
@@ -2659,7 +2633,7 @@ int CIFSFindNext2(const int xid, struct 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls
 	since file handle passed in no longer valid */
 FNext2_err_exit:
-	if ((rc != 0) && pSMB)
+	if (rc != 0)
 		cifs_buf_release(pSMB);
                                                                                               
 	return rc;
@@ -2763,12 +2737,10 @@ CIFSFindNext(const int xid, struct cifsT
 			memcpy(findData,response_data,le16_to_cpu(pSMBr->t2.DataCount));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls
 		since file handle passed in no longer valid */
-
 	return rc;
 }
 
@@ -2831,11 +2803,10 @@ GetInodeNumberRetry:
 
 /* BB add missing code here */
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-                                                                                                                         
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto GetInodeNumberRetry;
+
 	return rc;
 }
 #endif /* CIFS_EXPERIMENTAL */
@@ -3002,9 +2973,7 @@ getDFSRetry:
 
 	}
 GetDFSRefExit:
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto getDFSRetry;
 
@@ -3087,9 +3056,7 @@ QFSInfoRetry:
 			      FSData->f_bsize));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QFSInfoRetry;
 
@@ -3157,9 +3124,7 @@ QFSAttributeRetry:
 			       sizeof (FILE_SYSTEM_ATTRIBUTE_INFO));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QFSAttributeRetry;
 
@@ -3228,9 +3193,7 @@ QFSDeviceRetry:
 			       sizeof (FILE_SYSTEM_DEVICE_INFO));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QFSDeviceRetry;
 
@@ -3298,13 +3261,10 @@ QFSUnixRetry:
 			       sizeof (FILE_SYSTEM_UNIX_INFO));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QFSUnixRetry;
 
-
 	return rc;
 }
 
@@ -3396,9 +3356,7 @@ SetEOFRetry:
 		cFYI(1, ("SetPathInfo (file size) returned %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto SetEOFRetry;
 
@@ -3482,12 +3440,10 @@ CIFSSMBSetFileSize(const int xid, struct
 		      rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 		since file handle passed in no longer valid */
-
 	return rc;
 }
 
@@ -3563,9 +3519,7 @@ SetTimesRetry:
 		cFYI(1, ("SetPathInfo (times) returned %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto SetTimesRetry;
 
@@ -3641,9 +3595,7 @@ SetTimesRetryLegacy:
 		cFYI(1, ("SetPathInfo (times legacy) returned %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto SetTimesRetryLegacy;
 
@@ -3742,10 +3694,10 @@ setPermsRetry:
 		cFYI(1, ("SetPathInfo (perms) returned %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto setPermsRetry;
+
 	return rc;
 }
 
@@ -3789,10 +3741,10 @@ int CIFSSMBNotify(const int xid, struct 
 	if (rc) {
 		cFYI(1, ("Error in Notify = %d", rc));
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-/*		if (rc == -EAGAIN)
-			goto NotifyRetry; */
+	cifs_buf_release(pSMB);
+/*	if (rc == -EAGAIN)
+		goto NotifyRetry; */
+
 	return rc;	
 }
 #ifdef CONFIG_CIFS_XATTR
@@ -3934,8 +3886,7 @@ QAllEAsRetry:
 			}
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QAllEAsRetry;
 
@@ -4082,8 +4033,7 @@ QEARetry:
 			} 
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QEARetry;
 
@@ -4185,9 +4135,7 @@ SetEARetry:
 		cFYI(1, ("SetPathInfo (EA) returned %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto SetEARetry;
 


